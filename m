Return-Path: <linux-fsdevel+bounces-74780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIQgBJtxcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:26:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A552552087
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1DCA4817AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2E43E487;
	Wed, 21 Jan 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5E+cA0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887F3A7F77
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976783; cv=pass; b=hS6hy8nZIcTeZep5kqDosT9X8TBQNnbjwAmHBLaaxMxakdeaLVcKa2M3xT/ho9MsJKMx9NY9/uUM+XNKL+Dui7+qPhr7+w57PE7fMgbkwlGvx4v43GFjEixOaGXyxlK4yewAxsB+oQKrUX/nwhtXH+6lfpIgmqFUasSbZGZQOTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976783; c=relaxed/simple;
	bh=UvPxeiKs/qYsjhFYnn2QFDd2+HJdnsQY9bVtiU3Lj/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCWGbqFb9o7yrgeQQtxviIyiBiQLCjNA9v+fZRW/RLLd+Zn6WXihPlYR4FECubVlHsomH1qJfs4iYrcQt4GMZLaH61T2ErdB0Kjhz4tS4P1jeDBeQZvYce7jbbYjJY1Q1xWdKVu/tLktgWRoUqOdXdfLsYS7pHLenAqCNPpSWLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5E+cA0D; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6481bd173c0so5480546d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768976780; cv=none;
        d=google.com; s=arc-20240605;
        b=T5H7T9Xld7z3LPRbax+crvXq6eu3tZ3aT3DHZEHCzzRkhqM58NYnuqoo6w1JJ/8GNv
         FzO41drcdMxJuCQ1TFhLgb4XSZORVYxIWpNs6fKYO9Bpi5UtCPW8hV2B2jmFJHSqUEVa
         nKm7qJvXurFROZFKuAf0CSOjCtYFAlAbjI9qHWUSNdaGx7AXDQk8o79CcpV5MWFU46Du
         uqZAYj25Crt7wVM8vUxmYg7duIkmd9Uif/7FL2BSAIXjr9huiAbfUZFd5KG19eeSp0sR
         9AdIjrwF1BtjQwwRAuy+AM7VYYAzL0uJob7yxzVLvLKqgh+usiFP1uDClIgcptV6cSf/
         jmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kGyEDtvcc0GMSevO2YQZz1BfqjWPNn09jiCx0jwPX1o=;
        fh=SfvP0D6RX29VREk7yI5Yh6osCGUVJDtE2IsqWRX7afw=;
        b=RbI2UqCkGJFViuSi2G8fvqbEnVgiG1ThlpwhQ4vlDr6NRg6EPWq/EffCf0X/4uK/c2
         QVP1+2fGJyAoE0qh48erFHJAZL6ftiTa4PmPIDRLwPfG/vtPxTEV7kZFy97SGD4Q+kje
         ZU6PpwtlQkK1xyrvZAeJV/LmTd4hSt7/B4/I835svH9/ewsSqX1s92ltGqseY9SDrjxp
         419J6qfdWpIf5wS9VqJ7bpwy2mIhf8h0e8KxfYjFyBzM5doS/kLEn2Q0it3930v5uhJr
         aaZFKH2l6P32jCoUbpHIwkYtQMcZFqZxH+K49kxLP8SpSMx7XG20bYBDvZz34KT6dkB9
         KcqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768976780; x=1769581580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGyEDtvcc0GMSevO2YQZz1BfqjWPNn09jiCx0jwPX1o=;
        b=I5E+cA0Da5B64NB6GXsCD7Pff6oTXfCQ0W3Ea/+zaS5biychUlZmWMuSNNCTXUaYXD
         PIfPCiYWdo3PgqyouFpOLoRQr3RNhqTfSMtxAiOat+Qs1iRHBxLDVJV56nfdQN27GttR
         JzzLNdb5m3eVFd71Jqo0YjsUxX8FvqU+bW1Xi1Khq+N6bI3iBh6aQYsJqL76amR/oVu8
         Hxmfwa/FbhO1kfxNiCw9rtAiuSTgrO6KL2Qir9HTy9oI9pWh6MYO50e4mxsjBPDvY3YG
         UY0b3+l3i7sdnsFh4RvbLTlAovKswoNVf/gx9LmWdBZ853gSkJEq321tx4CSoKbbM5mP
         NH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768976780; x=1769581580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGyEDtvcc0GMSevO2YQZz1BfqjWPNn09jiCx0jwPX1o=;
        b=O+1E6QYFQg+e4dYZyU6BoQMabrgjp6ep/N5UZfC1xwvoTphOvIVTKhEZTDtaTDDJD+
         RG5I2igqXn9atFpKLzDC1cnGKvS+lxCBy2N23qkyTMudwfglSgTXe3ahTj4FJz4Wgald
         CxPz9LEPMrAH8nqmeL0qBN8LH2nCy92MGIuKyzmWHyPudFoh5D2Qa9oiV+Mn1pPdzC0Z
         4+Pak//kInvMYu8Ws2Dg6UBqQIFaju29WAMQw3m0Elg3Xos/ZD9al4/C8S9mGfaKF3ww
         MB0B2EaR74gcOWfGNW9gghfdPIcSEEIeMKHTG74eW8LG0fdTEjycHYDoyB4NMr2q5uCi
         bz7A==
X-Forwarded-Encrypted: i=1; AJvYcCXmCHsTa2C1VOIv4a76R6kjn4Mia8DIwaF9nfZubE+3TSbcFQv/17vzbeIZPcMYXhPYVy/aJN+CqfX6g8OB@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxBdlqP+z5+GeN5AZSdSMTb+bJE+/y7GD3oNSWsaOnDVNKQqj
	/B+qf1LUlx8XSJgq+19JZ8YYrKeNGVzIa3iKaOad25ubGObEMnsvGs8lwez97DKtBGN1MY0CNJF
	BzubLbmu4bTN5UczyYIfmcQY5qze44OpHQseA
X-Gm-Gg: AZuq6aKtdB+usmnZNnnk/3Pg/c9QDkvXcAOt3+doCOXMHXwGduaE6LWOVpuF2sfbWoG
	46lvjg/vWtMrc6cP3yn0Y04Vaf6TNuWTEOvppq0vPOFeatZaLUSKS7bDb3b2h/txXPgMKaum62I
	FTKZBcp/CNbiTRkZvyvtc+zs921Bf3A8D8ysxhq5ZTx9SKlk9rK/AmSaqm01O+y9MM9LuaABrqu
	1UWfFIcQknNNSsYkHfWJMSJvlda7xb0LT5rC+1gUtXOYiS5+YC7I4uOkpJwrRrwJiUVG7wsLSa2
	SfdwXbID5PWGqJgB+Hk6rvoqrP6s2PXFRELl2oIFhJfO2nfE4Tcy4Hq/1/k=
X-Received: by 2002:a05:690e:16a0:b0:63f:ab07:def with SMTP id
 956f58d0204a3-64917750bf1mr13166675d50.59.1768976780363; Tue, 20 Jan 2026
 22:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120051114.1281285-1-kartikey406@gmail.com> <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
In-Reply-To: <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 21 Jan 2026 11:56:09 +0530
X-Gm-Features: AZwV_Qjue2n7wNLdjCl6UBbRugE656HGqLbP0foc5WFq0xI_Q3p81vsmq_hLVJY
Message-ID: <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com" <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74780-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,syzkaller.appspot.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A552552087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:59=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:

> Frankly speaking, I don't quite follow what is wrong with current logic f=
rom
> your explanation. Only, struct hfsplus_cat_thread contains nodeName strin=
g. And
> hfsplus_strcasecmp() can try to compare some strings only for Catalog thr=
ead
> type. But hfs_brec_read() should read namely only this type of Catalog Fi=
le
> record. So, I cannot imagine how likewise issue could happen. Could you e=
xplain
> the issue more clearly? How uninitiliazed nodeName strings can be used fo=
r
> comparison? How does it happened? Because, struct hfsplus_cat_thread is t=
he
> biggest item in hfsplus_cat_entry union. The struct hfsplus_cat_file and =
struct
> hfsplus_cat_folder don't contain any strings and strings cannot be used f=
or
> comparison in these structures case. But struct hfsplus_cat_thread should=
 be
> read completely with the string.

Hi Slava,

Thank you for the review.

Regarding your question about how uninitialized data is used: You're correc=
t
that in normal operation, hfs_brec_read() should fully read the catalog
thread record. However, the KMSAN report from syzbot shows that uninitializ=
ed
data is being accessed.

Looking at the code flow and the KMSAN stack trace:
1. tmp is declared on the stack without initialization in hfsplus_find_cat(=
)
2. hfs_brec_read() is called to fill it from disk
3. With a corrupted/malformed filesystem image (which syzbot fuzzes),
   hfs_brec_read() may read partial or invalid data
4. The tmp.thread.nodeName.unicode array may not be fully populated
5. hfsplus_cat_build_key_uni() copies from this array based on nodeName.len=
gth
6. hfsplus_strcasecmp() then reads these bytes and passes them to case_fold=
()
7. case_fold() uses the value as an array index: hfsplus_case_fold_table[c =
>> 8]
8. KMSAN detects this uninitialized value being used as an array index

The KMSAN report explicitly shows the uninit-value originates from the
uninitialized tmp variable and propagates through the code path. The
initialization ensures that even with corrupted filesystem images, we use
zeros instead of random stack data.

Syzbot has confirmed that the fix resolves the issue:
https://syzkaller.appspot.com/bug?extid=3Dd80abb5b890d39261e72

I will update the patch to use =3D {0} initialization as you suggested.

Thanks,
Deepanshu

