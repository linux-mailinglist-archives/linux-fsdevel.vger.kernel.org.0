Return-Path: <linux-fsdevel+bounces-77832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD5TFa3kmGn3NwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:48:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F267616B4F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6CCE3033523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42D6314A67;
	Fri, 20 Feb 2026 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YdaW2WuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7523101A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627677; cv=pass; b=tU+F1f5XCNtE4Ukreyd/Q6Xxujk4KNZtol+qUX3mbDCCqp8wmpCxq/2A90fTF5wKCXLW6NWTcnetDcE4bGUms++ZLbCqQXTm1uflatQE38xOpW2SKJYmqrSWvqLMLYXBSuGz/+KHXZf8JOEEHKQIa9hQmSA8W5BpeCQorj8vbUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627677; c=relaxed/simple;
	bh=cSO5ddvam+3etx0tA+nKexvNvZkPWOiJ4oLj72nGz0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQVygIfmmGjHQ5g1z4yv2ctJ+3z+d/NIAjTlZ5l/k3Clm+0f8T9pYWRVErDRXs5U8+iqilOsXy21uH7CyamsLAoMk5iv0zjWLCdQxc9YvQhg9oReQh0Q/NP84AEsczF3BfBwAfIo5cn1dnkLlyhHxWQcDkKzQs40EajtAEVSuT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YdaW2WuQ; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3566af9900eso1390355a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 14:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771627676; cv=none;
        d=google.com; s=arc-20240605;
        b=AmlJA6sUqlsDzPfJ033WSbsoIXv4Nd9X8Yj2wog0KE0v6OXp6Yx7B6ca9jO1xEbLfm
         7qkz9F31sL4pqWaPUyGxsXw2zOpz3YeTXhcvkmndwpUaH5TOOiz+N12lcWpZO+wU2e/0
         dXc3z8CrSkhZ1IRhIr9ruGqrwFiP7MeGfiPdf1AgAjBgsOSG1gsB24VzSp+vkJzPGEen
         KWjNZxORrRt6zUbL279oqJEqO78P1B+b11Vw50qib5++HqP4KrG6bN7AKgA2K5GmdJxm
         cxY2g4RDAfGYPQpLODO3foOIZp77/5Q2OxAn31eApeDp4HfAUe2bzG15/mInd0s4aDvw
         /udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        fh=/I/dK4BecVAU19q1foUWXdt7UceCQu4NBQa2M6UfE34=;
        b=Gf+PbCjOxXlV7kqBadiNxIs/YOgxeM39ivZsjWxlTPfd9ctXXmCvQpxzl01RXIYsDe
         33NZ1M6OcVyAE0rafPqXpBKtRX40V00LLhtBMnYpHIG/xfXZrBZBvqmJsRp3YLrDbXmJ
         aMHJsjrkg6gOG3PoAEbptshDMrvCKusXVsWmDBdSV4mT9Nq8Y+kcSimB0X4z+HXqVH9z
         qgLoRCGl2MbYKBK/Ng0sldI8bqpPzXZADP/lZYyoT6SRMXoIQiEexKUftmJxic+XsqzN
         plIf9bgZdcKw03bLAzuGgKEcxYsvMM0euwowqtsameqNvikZRZWLnTxDuokmuK4vfZ2c
         LFUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771627676; x=1772232476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=YdaW2WuQ41wM5N1ATcsiXfFOfi8o+6IN5OMQAoEAgbdAjJkGfZ63rBEdcJ8rnXF3yy
         zZPc6a4bONe+ldk+YsvYsyF2kj29Z3wp3gNZOieGr1bx02kYKEQmVczXkyhrdPBmsOu+
         02nizDc9/b0WQGtrOR1H3GqDf0CUX/xKMH2X8B4mZpv+1BEK8dbBgL7id+rR5kElX7Bx
         n0PhraKR1StZolJE3zbIKZZSH2znoCletYgDWkfimFsMFY3R/x3k3KRCEkMEvmLYEC89
         hBRTOgyFJXJMoXD0XtDvmQ6JKkjmqmwBDtqojqDUbUMVLPW7sn6eTqD1FLjRPj4//pn+
         8/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627676; x=1772232476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=DfqaL8ZJFOqmqmQgnttZv2jV0NS0NFTr4ewLr44ES38G1eI5zDNde5UifIVU18/h3b
         XSNsTfGbnZZJDkaFL2ATeFFD7seen2ADvi9ld4EVHbtOUN6rUmCTi+vjclkeC701FaRy
         FG65S069gltXIDbeeQAAI8jK/EKU6XVL2XrnDjPE9hY860KrcCdm5bBZLHlK/Cxc3HEV
         AZW+wpcV+beVJZVWD8epUI9Aot5YJjKRfTuJZrLuBv2L78kY6HYsvwlqfmrnV7T/EyPd
         75/dqQ013m4bVp2yYSoz4swFW4A2sKGoGKjUzbOUur2zoRMt9K4myYrGQcOde7ue2lSg
         MIRg==
X-Forwarded-Encrypted: i=1; AJvYcCXe1XPabJNsUJSMf4PzYqjerb/afeeBM5vqLrsH5bDObIZXAN1NQrS+qYDrm0o4tRkku1pmP3fuqkAHQRrY@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdXj2sULOv0I7V8nbvXFtrmBrD+1KzbnnjUO6UyfqmHYK8xbA
	PKPGpVMVyzVbdrIac5YI0sHZmYN/sHuQ6//LkWUdE2DJfD6HxbcqVKXbfJW0Ju8uT0Pi7cxLzua
	I1jj4gGcecgCKRrwqvqc0wkOByJijmIyWKqwAe6ye
X-Gm-Gg: AZuq6aI1E4i3CmkJ3yMlfd5eD6dEQP8uaE6WyzVc9IfR8GloiXh4Glzx1fL75y+upax
	2umi5Oih/FTX4T6nOWqnXs0lXDi6xm0UmndFsBorEivgIGpp5xisQx6triDc67f5PVkPzasxYE9
	Pji8m6FJQlMJ5MG7eXkWQ5dXFNtuwZTM+QL9QQtpiqWbIaTGPTDwe2eFLli0Zv/RdrF3fT+vHt7
	IqilRaeG4xwn/l2Q7nyfwOcr3O54nBPTV/av13XIdNOpzAFUjcfoXGgIH/uol5oIL4SvoLulZTx
	FYpFhS4=
X-Received: by 2002:a17:90b:3a08:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-358ae8c0983mr894544a91.28.1771627675691; Fri, 20 Feb 2026
 14:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-6-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:47:42 -0500
X-Gm-Features: AaiRm531rz23NInLiaMybHfJxR35OGBc7KTvM6WC-U0WofFc5pma3F6ygsFUv1A
Message-ID: <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77832-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,brown.name:email,mail.gmail.com:mid,paul-moore.com:url,paul-moore.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F267616B4F8
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup.
> The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds.  Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  security/selinux/selinuxfs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Unless I'm missing something, there is no reason why I couldn't take
just this patch into the SELinux tree once the merge window closes,
yes?

--=20
paul-moore.com

