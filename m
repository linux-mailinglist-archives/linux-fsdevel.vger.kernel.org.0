Return-Path: <linux-fsdevel+bounces-77709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iClVDRsSl2n7uAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:37:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6D515F238
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D013013D56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154933A6FE;
	Thu, 19 Feb 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RPRXF583"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F531AA91
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508238; cv=pass; b=K7zP3V4cjMbvnKSyDqD5yQNVN4iUV04S4MazTd9HnECE907X/VfEchV53Z/jdb5h3x3VXV3OkTgaDULVVNUcQXzb/Uh6LDj/yQqaPhuY3lIG9F9CWmbokgHF9qX6WqbjvabZMmVEYFYk3dS1J80cxg7Ri8v94bDNABR5WIK3x4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508238; c=relaxed/simple;
	bh=GmHo0NCL4ge/ErKlzJei0vodTI2hTzHGWFJJ3MMTDoQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rqWtTSyr2JXMn9KmVyKo1CEc32eCHeKzDvi7eoVoEQ2GmWbGDctypS5FrBMVm0jdM6fkvSqzXijrm6fN3CiBG9U5vJzT9vz84X9MHukUwfRowvRddC0etxebO93n4yV7b02qfR1ghKjSFIrdevMa3MJ8vLR1hWAzNaYFOvNfdHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RPRXF583; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79273a294edso8134937b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 05:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771508236; cv=none;
        d=google.com; s=arc-20240605;
        b=hdaZsNuo72SchrTtcjHoBGyB2XNDczM9s8t/IcbTWj27TFN3rsn8A20yI//BOHzK15
         e9DT7AyrnQRAfIGXucFKWSi689u256KdeFMBAy8UDoWqj+Tc2wbOdaW1V03oonfZd32D
         RcwhxibAgQbYyin9/+6f0wFGmFjtbI499wa/SSmNZJnSKD75i4/MKZgPyZhCPhFiaIni
         VuTJZN5l2hbNHCGQaAWWzB0HqRLWAqhWJ6x7Y7F9YGKs9eP9NuD+IuAp8GjGXpJhMRWY
         Lu+cqzxG0ZW63QrMVWMvq6H8r3Z40yEZYX9ClcLcQYQ8k9NwzP/pbPVOKis89F14Qot8
         b63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=tcesM3lSjBahtXo0LHg5TOyW8wOpWKXFGTMFHZPHM9w=;
        fh=ftTQKdqRjWOmeAcT8OgcDf5lb31uFstuAg/7ODeUOfs=;
        b=l2vukAP06MxP6ZjZl6TYawEcHMyDtXCtUrpUFFfIrnAdwpAyPzowx5VqnOAgKXRupw
         WGVjwCPQOxE2SQzL7XwJ1TE4DVVmCBivtSKciIIVEiLBTh7XA/MGsHqhfm6GKYgnQPbh
         seUrwVqgDtcNWMWcdprjn34DsmO1xryzjnCjo3mjHdxvOaDEMOd6eMCU2gVzRdJLm/2A
         7fqSA990hS6CivUYvaNP/EgDhteKW2azemDMI+kcfMvgwa4SiHYjgZZsNKCtiiiTHx7z
         r79pg8bz+s7el0rk/0nTqI2l8g2YHmOHwIvlRmNDKpr11wLRwb8KK98eSKwEN1Nn+15d
         EqCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771508236; x=1772113036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tcesM3lSjBahtXo0LHg5TOyW8wOpWKXFGTMFHZPHM9w=;
        b=RPRXF583zjUr9kLpSn9lofJHTsCiKArrm9nlvx8scRT7K19BqfhgT1h+pnZ8x8ZDgh
         OGtm6RYI3mNfBnrcW7HR5XlB6jPvMsIleRIeBuYV/11A717OJuOOdv0zFJH2YntOSQdM
         PmHdi46hywlf9WY8+8aSjZJC+dhUS+OPj70fAkWtj021T4e/9fnB7OXVCmCCSJYg4AIv
         2BMvjB1zoF98quvTTrhHito2SL41gT9+x2Upjn/rpd4j5cRbCNnkicokiHTk8fitJN8p
         xsRbXw3Wd4FBllEOgsFAln/mqSOC9YX4cVtnPQ8beh68VzxTW7LhY8D5k8H1ZpNjcU0O
         nGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771508236; x=1772113036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcesM3lSjBahtXo0LHg5TOyW8wOpWKXFGTMFHZPHM9w=;
        b=iZGnrwxjaN8vZ+Oh0fL5n07S5MNPzBML1jd/E5tvfQvBW1ScngKN4rOLJgtp5m7DKL
         EaIMLF2C8q/kBHKe0nMA2F/LtMsaxye2X+CUQz7vvBKEadCPm1x5XvxMvTbtjBgVeStJ
         3ojnygbL9Soo4iPkCgb3kCwTWCV1EXAjKvvtMSMTw8UxR3tV6nEl571MjEGQfqxy/S/9
         y5IEhGLL/vMRPj2WTl06xhWPiBYub0GgkXfNR93+elAHLOJ9rb1bkaYv88duz7nfxBeJ
         T60AttEufqSUO3h8Yxyjuiu58QAaQw0jQ/hNlhAvBb6ajOeDcuSWdvtNdTVPho6nk7ou
         A8Vw==
X-Gm-Message-State: AOJu0YwT6CTpZhm3Brbqpwl5bwy8cqYUAGbBUnUCsEzxZHEWn3yllNcT
	lSuzgX7Aj43gyBuhEpYKKAYJsWn7Z33Y+5IO0uJUMV7LDRRYBHGGJZ+TWfFNSvmG09zE20VvEOX
	PJBEkIVX9hqRQEfHeCA70Sdsr5A2E3m/vRIvTW0c=
X-Gm-Gg: AZuq6aKxI47fo1OmU43dh5aJ6VkHnWDzRNpdIx9ueAOpeCdIj6vfAQR1Z0R1Xyg5Q+5
	25vP3ZqVbeMWe2iLsXwGmOVd3B46k179B92Z/mG2hnNEOjbyPEwxw82nJQTc77SIXefYijEcW/H
	Klm2GTZ8BvBwnP/SpehDKzVvfWMQLjqN3EfPS1alFTxVb3AE75IvHPqdXZ1gLID1jjejSoqoJRv
	sjXuok1SgooEOgvotTEh8iL2Vcv/k+k88edo0iDAv6PDguT7L9mRjVkC+t6/iQElIFPgMq6oRoD
	V96j
X-Received: by 2002:a05:690e:11c9:b0:644:60d9:8649 with SMTP id
 956f58d0204a3-64c556dc612mr4509989d50.88.1771508236398; Thu, 19 Feb 2026
 05:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 19 Feb 2026 14:37:05 +0100
X-Gm-Features: AZwV_QhEG-Dbyjabvuwr7JbE0kl4wjXOO6wTvaJKJoCU6g6GjPFeSI54b6DzZ8U
Message-ID: <CAJ2a_Df6GOirF8TnNWTqNMpdWLHgjT9_v7G-PiL4e7LU2nr1PA@mail.gmail.com>
Subject: Generic approach to avoid truncation of file on pseudo fs
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: SElinux list <selinux@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77709-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cgzones@googlemail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim]
X-Rspamd-Queue-Id: BC6D515F238
X-Rspamd-Action: no action

Hi all,

SELinux offers a memory mapping for userspace for status changes via
the pseudo file /sys/fs/selinux/status.
Currently this file can be truncated by a privileged process, leading
to other userland processes getting signalled a bus error (SIGBUS).
This affects for example systemd [1].
I proposed a targeted fix [2], overriding the inode setattr handler
and filtering O_TRUNC on open.

Is there there a general solution how to prevent truncation of pseudo
files backed up by real memory?
Are there more ways a file can be truncated that should be handled?


If there is no generic way would the following patch be acceptable?

 diff --git a/fs/libfs.c b/fs/libfs.c

index 9264523be85c..76f7fec136cb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1089,6 +1089,7 @@ int simple_fill_super(struct super_block *s,
unsigned long magic,
               }
               inode->i_mode =3D S_IFREG | files->mode;
               simple_inode_init_ts(inode);
+               inode->i_op =3D files->iops;
               inode->i_fop =3D files->ops;
               inode->i_ino =3D i;
               d_make_persistent(dentry, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d..9f1a9f0a9b48 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3225,7 +3225,7 @@ extern const struct file_operations simple_dir_operat=
ions;
extern const struct inode_operations simple_dir_inode_operations;
extern void make_empty_dir_inode(struct inode *inode);
extern bool is_empty_dir_inode(struct inode *inode);
-struct tree_descr { const char *name; const struct file_operations
*ops; int mode; };
+struct tree_descr { const char *name; const struct file_operations
*ops; int mode; const struct inode_operations *iops; };
struct dentry *d_alloc_name(struct dentry *, const char *);
extern int simple_fill_super(struct super_block *, unsigned long,
                            const struct tree_descr *);


and then adding the hook would just be

-               [SEL_STATUS] =3D {"status", &sel_handle_status_ops, S_IRUGO=
},
+               [SEL_STATUS] =3D {"status", &sel_handle_status_ops,
S_IRUGO, &sel_handle_status_iops},


Best regards,
       Christian G=C3=B6ttsche


Link [1]: https://github.com/systemd/systemd/issues/37349
Link [2]: https://lore.kernel.org/selinux/20260130171140.90966-1-cgoettsche=
@seltendoof.de/

