Return-Path: <linux-fsdevel+bounces-78664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AILwBS3poGnpnwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 01:45:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CF1B148B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 01:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB20230616C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACA27FD45;
	Fri, 27 Feb 2026 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="i1OndWU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E226ED31
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.139.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153100; cv=pass; b=YtJHw9UksAJsLa7H6f4ocCgA+e00nfegfwy4njTI18vQiibFOYfy9zXw07j3LiVSZBvqAgBV51qk6pGGvX2yioMuO2iCH0ibBXomhC+KbZEtSHsbAifjInDyqBGRoCG37uWVamKGp741hq9uC8GvM6qENNH76F1wwvkKk4f8TKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153100; c=relaxed/simple;
	bh=O+HRxgiHT2z7n5ch0TYyL93nG95Cvo9LlcSt25e21Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo1/wE1d2c7XZnrkAZa7Uk0YMf8IVKQ2JF8g/utK3VLTCl8wbJCy2wu0BxqEQqRYGlv4t/lCJr//rgvFB/6hWyeq4brhgZrmRzdNvHv2uDT3hCpn7mvdimgspwCJs+ebwXNTMRuhpyCiswtus33zPEGYYnQ6/S1UdW6c9XMVm4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=i1OndWU+; arc=pass smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R0SNam3331655
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 19:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=X7pD
	kBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=; b=i1OndWU+3hVbPOhJLPdB
	3dZ4nSkztb1ikKbvdbatjVGkVMLfV8JFZoIoELwMzvOYxfwUR6nLGakr/qfu4h1Q
	GO8wKJ8wC4UazfM1LbiYLaf16jQ5TxOebgu7QRs3IVlvCrkOwzJVdNdZd6DNe2SA
	UyzFa/gtDwTBn+WHSFtqboptIKXNMRyDXiRy1/HJUeBhpCt4ysnry1Waeo2FSSbr
	T44fjXhU7o2QxsSczc0EG487y0F+MHbUzU5UXRAbhPw2wSNZ/rXct8p9OvNCLgVx
	J8CkKDZsIksblH1voMgwtFzQHi7YdkePQnLp9goufCO+S9tQvuISr4koC2RoM7Sx
	xw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cjst949u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 19:44:49 -0500 (EST)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79801be4ca3so29440587b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 16:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772153089; cv=none;
        d=google.com; s=arc-20240605;
        b=VOl83q0wm18fdd1TEg8zZbIYqHYzbbJkNnu6tFx82TMPy5wqqpr8oiff+wkkGWDJQC
         XwfDrLnCoJ5tgQqp6iOm3F0jAA9PgbvSBqgtOWVNiczzPxVWsVZBrYXpVFK/xZ9R6fE3
         1n8kc9JI9pFmePSVRu8EImIKIipAGjfMGugREFhzXWBJ1MIsOKisa9a6c5PgX2acJKrM
         diRmohHXdpgUFVtwHAnFgF5vor9EQRci8nJW+E1gFbuOH6SZ/SZewWuynu3wQape12gO
         UnqTEzMqKuV+lNKJgfsJg/k6bsuX9rpf892LjDuVAKUZDC/ONqVZeNJyw2//Ld3Mg7AC
         lwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=X7pDkBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=;
        fh=Id18EWqmG+KShQoYv4YijEHi2xwlJz+laQfJCivN894=;
        b=UQ6dp83h87kiRx1ZxFHC65n7ZEys0ZakGkmgegPh1qyYaokQdfPrBzNVEHMtvw7Tvc
         3GvHT9ukWTmNfFGR7NVMv0ouulcrqfaU7JBvTWiwREZig6JPnqLeXEaOHuYPhbgfddBd
         C2kNyGD8qYFLnp/KylcBKhZGKJM5lPY3Y3baOzCeZInEEaTXj1+LfeT2RifzkKOJNx+7
         F1WnYD4cSMEl+GkjuLvt1Upv24dRQbUTFLNzmuOdBLUMDBR06pKz4Iyuol6fRY+Ke759
         9EfNnIgsfVsTrx6b8+dBgia2JQVi456coWzjAm/67PocmNYE1B85yaqDafvWpK/LGZ6j
         aZwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153089; x=1772757889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7pDkBpYJ27xEgY18ooGDGOhBD+yHFwQylYRdDgNI+M=;
        b=X+R6JqQRxXUcJrrbqMNL2zZXzvc2c5TsaUrvO6SH4VJBSfAF5ea7n6MEzXIZlW/qsB
         lw+xOALAWlm4fYuiXQ71nHF3LDsjHprb5JUzGAG/leSvmD/EBINSW6wJp8gsNVMwSv/E
         C1QA6aOQUHGNBL2RNG+Na4rVvLvNhWulfa3gJotD12dp8/cxtebnrDByjap1hlzcDZH3
         1l26sbGST8XwgWSlZD/9CMrWdES/wLf3wMJ3nTDMK2XEImt3IDsdyF4OH4+sPRTZzS/C
         q3boKixENcdX8jm95N5R45nJNCULB7066DBFUwmeRAdbEtNsv652OAkHi3fVU7RftkJ4
         7Xiw==
X-Forwarded-Encrypted: i=1; AJvYcCXznplDBxVyuQ/6mU2rqGiN6eeKbzvawxZ0Ja6AXX/KayiBC8u1eLXbqG0GupLJekRdN7CEgDk3Cmsi5jur@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdZh3iUbA/atuPscdBtqemnmYSIeLd5gIZ6q5f7Zoxu0LjHIT
	jbO1mHt9AfOMG9eqkdyEikogSMDeDE/k8momkUVKTapYW3INNk0lUSOpB6cxwlR010yU+Q3WG7X
	6JUIu+VhIqnAoa7YMQbjufLY6GHpt8THrAqqFmbXW2PnCSQw8+4ziORXyQ+u/wz5Z70gw5sff5j
	lExcDaRVJHFtZFi6JajSeBUeLpMiQKLEZ17kZC6g==
X-Gm-Gg: ATEYQzzLeIyXCDH0KHoBFXItH0J0s7XlrGDnk6tUH1iAcnT1OOngHbzLeLhBJfEFy1x
	7/owlgIBK1GtkHREvm8Am015+ANAqRqcyvmJGthQaFAsE7Iuw1o7oeoQhE7rOS6JDY1nVcNnweD
	kjRFGSURiZL93aHdb1slSH+T1ijTXacMSu8zyKypI6R1CDcniTuFoNYJkyK4xZVsBhamHnwnndF
	ieHGw==
X-Received: by 2002:a05:690c:f16:b0:798:6401:fd1f with SMTP id 00721157ae682-798854a7e4emr11636207b3.14.1772153089305;
        Thu, 26 Feb 2026 16:44:49 -0800 (PST)
X-Received: by 2002:a05:690c:f16:b0:798:6401:fd1f with SMTP id
 00721157ae682-798854a7e4emr11635807b3.14.1772153088806; Thu, 26 Feb 2026
 16:44:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-2-70e7ac4f7108@columbia.edu> <aaDEEjVKBKrLxsht@infradead.org>
In-Reply-To: <aaDEEjVKBKrLxsht@infradead.org>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 26 Feb 2026 19:44:38 -0500
X-Gm-Features: AaiRm52uN73WQ1q0q0Bsy0nLJ7MoTUQc88yWQcbleL3GQlPfTUc323g8dJKyM6s
Message-ID: <CAKha_sonOvAGriyromHtyRc-VY6Zyg3J3zd9UJPfBOAt1a522A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAwNCBTYWx0ZWRfX6CM7a/l0iQ2y
 b9z7NztbDx/vLy+lLr8wj0JiXwXCyYJX+Z2g5UID/sAh7nwKnqARHvR5XyNchwvnMyI6NAkBRnW
 5/FMc9CKeR+lYxgK1YZc6L3DWk9Ou7dtWJLyff1aA01ZVf0G2BFkptso3AtuXf94dSYtr0gyhWZ
 3lG2O3V1WXfPBfUikW8wgmRLDShc67REuU9IT2OdCjsoSflibtFJsRcRpFxNT81acf2StZXnYn+
 jTVoL5s9LydpIPrNYcrn4Tx9vH2FUJC3ZIiYPbqr+Qe1cTkLDH1beWAZhD1BYTi9IHB8yk+LZ+n
 8FGL/6nHJtnvlcvmEKrQiXbvGBgTCx/7rf8/bnFTRwyZeEdUOc6EZHoyH+5/prf+6+tviUWKB+W
 to22w4o9iylfu25hFvagzuRLPmTHWPmgjiFK7dHRk8EeIf/08aSso53NYcMrKJKRg3vAQMdDs2Y
 HFEplEKCWGxYPRGG+Rg==
X-Authority-Analysis: v=2.4 cv=ebMwvrEH c=1 sm=1 tr=0 ts=69a0e901 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=Qm0qsxP7aFY2tkT6R2MF:22 a=JfrnYn6hAAAA:8 a=lVyRQGvDAGr_LZokY8wA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: -PQEveX_d0MLtbzpPLCE2SMy3nkLWlys
X-Proofpoint-GUID: -PQEveX_d0MLtbzpPLCE2SMy3nkLWlys
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 phishscore=0 lowpriorityscore=10 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=10 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[columbia.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[columbia.edu:s=pps01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78664-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,samsung.com,sony.com,dubeyko.com,paragon-software.com,bobcopeland.com,infradead.org,linux-foundation.org,vger.kernel.org,lists.sourceforge.net,lists.linux.dev,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tz2294@columbia.edu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[columbia.edu:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 8C0CF1B148B
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 5:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> > --- a/fs/bfs/file.c
> > +++ b/fs/bfs/file.c
> > @@ -177,7 +177,7 @@ static int bfs_write_begin(const struct kiocb *iocb=
,
> >  {
> >   int ret;
> >
> > - ret =3D block_write_begin(mapping, pos, len, foliop, bfs_get_block);
> > + ret =3D block_write_begin(iocb, mapping, pos, len, foliop, bfs_get_bl=
ock);
>
> Please don't change the prototoype for block_write_begin and thus
> cause churn for all these legacy file systems.  Add a new
> block_write_begin_iocb, and use that in the block code and to implement
> block_write_begin.
>
> And avoid the overly long line there to keep the code readable.

Will do.

>
> Note that you also need to cover the !CONFIG_BUFFER_HEAD case.
>

I don't think there is a !CONFIG_BUFFER_HEAD case. The only user of
block_write_begin_iocb() would be blkdev_write_begin(), which is only
defined under CONFIG_BUFFER_HEAD. !CONFIG_BUFFER_HEAD paths use iomap which
doesn't use it. And buffer.c is only compiled for CONFIG_BUFFER_HEAD. Unles=
s
I'm missing something?

Thanks,
Tal

