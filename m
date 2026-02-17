Return-Path: <linux-fsdevel+bounces-77333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB3xD6Hyk2n/9wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:46:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A0148BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 420D7301BCF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8181B7F4;
	Tue, 17 Feb 2026 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmL61kHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B21E5718
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771303572; cv=pass; b=b/M+PGPQ60LgmJFLMhv1tRUU2f3j1UVK0FOiUPqOgih23Gbu2RXQqgHVl29Hu00HVGuSCUSEXanvefA/C/GjtgdT5nSiGx+llRdNoHLyMMPOOrH8mENX1ymx+PcWgh678mwwD5vMEGWH+zU435ukidnTsrcItvNKsupGp7Ks1ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771303572; c=relaxed/simple;
	bh=nKGvllvCG75fwMdLnJD7PMiU4Ur/hq+HZsbw0YKAafk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nnJLEKs5FaMU0RWPhH7URJuD00iXH5vmmLaLE33YFfzh0F5YIGmpmRAmXIjDSk5FY8B/5RikAhX5NDbkacLn/BH+Vmt8vikTTxgCNPV34RDOZwCHZqzfhs2pWLLAPDfAhWJscaPtl5JYTO81P0d/1GMZWY+biqnie1he0Xt1Xvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmL61kHQ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso7282937a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 20:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771303570; cv=none;
        d=google.com; s=arc-20240605;
        b=HaQYcvbarMq0D1xjRSX7X4e/BSB8eqkb8urjy1pVZo8786FmXxbuKkmixcfyaDAmCi
         z+CAJQbxbi9nhtcnmSy4SLfUiF0MXuMX7IWL8iSgDpuJDaXOlXjKGmxV10zDpEaJvOuk
         DG6WoMhRUcPrj15fgLH9RkC9nG5jBUkjZ+BDNljXeQDzqObrqasToEQzXO+qXHYr1sQw
         VXz/kYAXh+1fFcSNjwDhFIxJMA/y0J6VFkF1soysU6wsQmNwZTdwiANSfckzIqVY6buh
         g0Hm0YbQT2BXHnr/zFK+v7C0Lf2GenaJjI11epZd9irRlP4yvA2hLH2ySJcNFHwtwvl0
         MXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xmAbP1npaRP/EktzRfWlFJfADINwj1eoIm5/zjg+zdA=;
        fh=Bt8L/0DAKQFYtHMfmRrQrwz+cMLOOb9Zp7SWam2eTJ0=;
        b=KcPYZ3XSUmFB8hzp0MWAhIv8VZJ34uO2jGjCeLR5MxlpnX0XZGHIpgA3LGARNgJa7O
         WRv3SxyIy4PppsAJOJhZvxehzUBZAvowwUtPNUfXPyE9EdvIDggG9PE0+9P9oalKpSc0
         UwNmucaQ7vtLJR/F14l5SYLXj5ymMtKlzVLp5PSV5HlC7dT1ur+aWsc5F6DwPfLFT4Za
         uUx8MTz2+EGFT3G9SB7+p2zw6wNY6m66rCbfK6axV1lVIATJmEbrS7WfSlrHzT5kg5NU
         6wQo7aX+I6tCZa0mtBhOJ4SuW2C0ZEcXe9ShGCf+KFUk8Y/sCQts/BSunK6Ch0S5llRT
         ipHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771303570; x=1771908370; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmAbP1npaRP/EktzRfWlFJfADINwj1eoIm5/zjg+zdA=;
        b=HmL61kHQ48KFTO1gsVXarVuiJNXp50WTfuB63Okct4sieIhJfriayZIVlmYOu1xVwW
         MDKhesC6dJ09fcmTla5KrSOj+RwWWP9TMVjSaqx6suXMPohnE6SUR1QLbJV61uzvj80O
         It0mp8L5Wpdn3tFodQZX+1URJcOCtgJxx8Ig3cv5E8P2gUJ1dZ7shE0VsyH8ZyyXnQi8
         qpreqeBufuzZbVdbP6DFXvdY6fzphWloXRDgngtJr7MdGeALb8IsJr6611/PwlcFbmI3
         atBCDWPqoxR0ktyP32f4SRjGT3voDrqyghUijtWySbjsivmu6u9RcPZctpZS345FEoFh
         Ffsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771303570; x=1771908370;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmAbP1npaRP/EktzRfWlFJfADINwj1eoIm5/zjg+zdA=;
        b=OKkmlA54EOBaMPouWwZ9xcwc+lzYmkCmgRlEiWTKSiHCPCJTYpjxcWqxRVKNEJCsMW
         IVCXYfMPyIDoMe1wHgqy3osy3FU8lNM2VF3/pOZ60W0HZXhY9Sd6iF32Gq8LD87IEim7
         tr3mVYYE3DJ9MQiWAzs4EmyxalQRT2eiTRUr7bhg+IfBUJ8EJw8VxokM6+3sWlPCnstn
         i8wIPf88UhLDSNT9jzwASL+se0IxqaH/ZK7Vd6X/nqVxR2xjHLwivoVe/DZGz/uPanT1
         Q7veS7OD8cxF16nhIWT78+ikyByn/IBO/FAYsFRtWCIUAL8zX6F3koQqqT3XDL+1In5M
         woug==
X-Gm-Message-State: AOJu0Yyg2iT/MQur2QlSdiEcRwjREPKfLtfWlK9kZFE6kCDhMQNPBjYl
	xXbcR7gu9YqxhPnrzLPh0lpdFmQmuR0jm9EWUt0OImpjL5t5uk0/kU8AOEvTMbUqReujA1exgoT
	jREDV+T4SDwTWTt4ZfwksrIuYDHeQCXBgq0IV
X-Gm-Gg: AZuq6aITW0c0XBs7cW6WnDRTe9PpdUrWt+etJPysMjfE/U3R7IcbXZXCMpNhpyBX4My
	rVDnLJ6d+50sA6ePMRFKx3nJnvVOUN1GzSA6qf+NazB/IDqwm47fUVoTbwaStnPInOkluezapj0
	E6a1nvU8WPI0jg1apacVDDXMuDVvnQGEvfehaRxA0I8SEd7P43XWNv0Tc52YLp1nfQCbRNBYzqB
	VR9YPimgJrbkpMt01y8aghVvx4twiQeR3f4Lh28bsC04mxjDh9Sa+CA5+gzFgtX0kVPFf+Lsx0D
	3ojWTg==
X-Received: by 2002:a05:6402:3554:b0:659:31af:b9af with SMTP id
 4fb4d7f45d1cf-65bc41dc297mr5553172a12.0.1771303569746; Mon, 16 Feb 2026
 20:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 17 Feb 2026 10:15:58 +0530
X-Gm-Features: AaiRm50t13k44Sen9NRCY3Mfw1UqRelWB9C2dA3RFTYoLt5Y4mPqd0YjIZDY934
Message-ID: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77333-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 867A0148BA6
X-Rspamd-Action: no action

Filesystems today use sget/sget_fc at the time of mount to share
superblocks when possible to reuse resources. Often the reuse of
superblocks is a function of the mount options supplied. At the time
of umount, VFS handles the cleaning up of the superblock and only
notifies the filesystem when the last of those references is dropped.

Some mount options could change during remount, and remount is
associated with a mount point and not the superblock it uses. Ideally,
during remount, the mount API needs to provide the filesystem an
option to call sget to get a new superblock (that can also be shared)
and do a put_super on the old superblock.

I do realize that there are challenges here about how to transparently
failover resources (files, inodes, dentries etc) to the new
superblock. I would still like to understand if this is an idea worth
pursuing?

-- 
Regards,
Shyam

