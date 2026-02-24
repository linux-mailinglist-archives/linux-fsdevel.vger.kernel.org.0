Return-Path: <linux-fsdevel+bounces-78239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GODUAKp8nWmAQAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:25:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C21854BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 909B430AA075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE41428F4;
	Tue, 24 Feb 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MChaKYxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251C374185
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928697; cv=pass; b=PDwXX7whLj1YJt6ARRgScTFgfkrDv/ObSO26kPTP6Ng29qzo8OLD6aqXyeKrGVV336GaBx2DrGjQpqfyZ9gH8FKOM8pRbe5Vzc1KxWXTQO0eyHMIA7vKaoMrxpTIWPZEM7DNENNejQS/yyJpARdX7J3+fJr5kA7VF7hB1kVVIKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928697; c=relaxed/simple;
	bh=hHRJy8QJuXqrZvRYe1s2e7pWgh0LxMfTN14cPF1l6/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsbSdd7i1x/DAFALFS/1y/X3gzYlqktlneQFajjrKFmaKIkMmB9qIu1rgyNeUeyhwmWpkS7EEW8S0eHcWxKISSYbtNx9kEY1ZxYDDfzIKGW3VEOmiWO7OYU5yqR5LvnAl2Kb3AtL9ogoqdawQQTHKB3vfc3J4r09DDgaLckQYRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MChaKYxW; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c20dc9577so9921692a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 02:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928694; cv=none;
        d=google.com; s=arc-20240605;
        b=YPYb7U4QWXJlDXFRvfi3l5D0+HMgVLwjWmYAifA63lDgHBrbOxmEyMzD4N6qhvFT7o
         t3PGR0QJSFFhBqETcwKDJ8uPy1Gf3gj1PJ4KSYDT3vMXlZJG30DKIUOftX5ODpYRe0et
         S52ygVxrKvS+Xeyh0FuRe9VTl2dEtGUY245Rxrx8CVbwGZK3+0ESe9nd4jPhRfA3yBA7
         pYkgfyhdhbzYu+jLpfhIAYs87wtCPJGm6vLRReZt9eqVWo+dZytVpjq/P0Tsm0g03CwM
         thX/iBFSz2nh/E8pY2Al0d4jkhnCKFwaW35FOy0L0eRKvTLHamNyN12Eruw2qMN5AY6Q
         VOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4CfP6ijHdd5S7Ck6QpALkZNQy7jw70n0RYyKMKxeBg=;
        fh=a8DVNeIpRc2mxMnEeVjgwiThTCPbFo+LbNZF77tPcXs=;
        b=YkYk0JKwMAOfJZZjHiLpisB8YnqKsdHd5QEPACAWzFqS8Va6KpeT8wUO0CZ8achr7N
         24nBDwWAdEH8F5hjt7A4q7ngq6etc9WVbdLCL5pN5JDcPIrNyAezfTo1iz9IT5hVROrN
         TOKHeXmDfmYGmPpF3O1rfi/VEoCESjl8+oYJTzm1SiZjqQ6R0+MLh9LyWJZZZSFgVCmQ
         6yw/Up0sPUGyPoMyj+A4zX1/CDFY7yB9VUBnIxA85+qpenb2YsJNXb7c0uoVtPXpn/Ek
         cES+KGl5riZx3EmfMoqM/Xs9DeWngcIVnQIhfUUJsdSD0KbpNYOpYIHCzh6d0HRBFzgd
         Xx3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771928694; x=1772533494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4CfP6ijHdd5S7Ck6QpALkZNQy7jw70n0RYyKMKxeBg=;
        b=MChaKYxWvD+DZlEUZHvsI5mLm5EpSg1ddwUMmGClKk5+7mOWr0YwhCy2KJSflhFQYR
         +d+KHhkDKi9kCl6afnU1ilBRws0fBmZmNBPo/EsPCJ/c2UbUJFpQI+5aYObhN6pGo9gD
         CtypBg9If3bVDqJcbqCJjW6ymIJJLHkhCHMHe8Qs6rLZrSpYL3Nplxcn3OH8+jUr25kI
         WeDzG8yTRbMDSiUD0b5URHmZnxqE+YllpX4S+3nP4cd4zRlYo6ToCH+mSJ/X1IW2QT3a
         LJP5HdmauhUvgYH/bgElNAnrLRz/2mxp/cVF6Bq0+TlllmQDpEDKT0ifOg/ZJNn9mvL7
         dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928694; x=1772533494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4CfP6ijHdd5S7Ck6QpALkZNQy7jw70n0RYyKMKxeBg=;
        b=n4l/RztwfT8S0JtbBTADNW0SUZHC3WN6d6GtuXc2VViMJK0FYhjGPpqZcoSYbFVzCw
         GTYF+RPoIXR5mKh3v1ZFiqmYMpVGLhIdUVCItpxqY6VeDwi7WNSKhDAPxo26MWeFpE5V
         ra0KPNqPNfQ/UDK1cibpuJ5bY37f6euUMeCl56zpgtojG2hBnAdkc2lACXBNrPckAcyx
         sqJv0RI01aphMbkZ+LFP9WFL7ShTMRu+jWqSHPk0i0B/W3LEd5DW/2M+HEFKrB2oa0wI
         rK3UvHRAT4qpZyMyXtRBGGvKXM5m0vn5KrbunGHdfA+PpCberJgPR7z1/I0xS5I4cIcP
         gtIA==
X-Gm-Message-State: AOJu0YynqR7jvDFDgnydt3aLY+ctlbEWejxxhLsCso7sqS//Gk9C43cM
	MmAOPEXyQ3ki4ENzVeA4m0LdhDbmYuXl8HfKhOrn8uG5j/4iLvEKWD4a2RxYo0fy+4zr3um+IgC
	NWv3MZ2QV5Hs8NTBb7POg/a5ysYv34kc=
X-Gm-Gg: ATEYQzzvaxm2Nr0zAzIsxdJhQ2hoomRoRwIDs8HNQH83aM4+jzoXv5kIf2MPYZdHLnn
	iz57j7cMkvV11wvRkWbj4agcs3LU1IE36KeVQlscQpYGiOsyOGecxNoFJ5HJkAQVGF0nkEa4Gru
	tP+ItEDJHNItzjHp2lYTQa43E4hHPHf8NlM9w6jlXbbaznzCEB57j0BlIbipVCWieKKmiMj1e4K
	IURSSaaYUrx7rX+m5Y4yEG3vg1f1WluUMddtiO+HWhbHOFyWF/RzaB1sSO3Ug+7lrMzLlba3Lmw
	r6HHeg==
X-Received: by 2002:a05:6402:13c2:b0:65c:23f0:a7f7 with SMTP id
 4fb4d7f45d1cf-65ea4f1a749mr6987443a12.20.1771928693804; Tue, 24 Feb 2026
 02:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
 <20260224051729.GB1762976@ZenIV>
In-Reply-To: <20260224051729.GB1762976@ZenIV>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 15:54:38 +0530
X-Gm-Features: AaiRm52xL9joVWGaho_Wba2a4d4msaJGHOfSe3rD-ekT6QA6DAsfPGrW7BKXMFM
Message-ID: <CANT5p=pDDjRGF1_vCKvmK+PvXpMQTOquZEEdddFN9mUdTiksHw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78239-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 723C21854BD
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:44=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Tue, Feb 17, 2026 at 10:15:58AM +0530, Shyam Prasad N wrote:
> > Filesystems today use sget/sget_fc at the time of mount to share
> > superblocks when possible to reuse resources. Often the reuse of
> > superblocks is a function of the mount options supplied. At the time
> > of umount, VFS handles the cleaning up of the superblock and only
> > notifies the filesystem when the last of those references is dropped.
> >
> > Some mount options could change during remount, and remount is
> > associated with a mount point and not the superblock it uses. Ideally,
> > during remount, the mount API needs to provide the filesystem an
> > option to call sget to get a new superblock (that can also be shared)
> > and do a put_super on the old superblock.
> >
> > I do realize that there are challenges here about how to transparently
> > failover resources (files, inodes, dentries etc) to the new
> > superblock.
>
> That's putting it way too mildly.  A _lot_ of places rely upon the follow=
ing:
>         * any struct inode instance belongs to the same superblock throug=
h the
> entire lifetime.  ->i_sb is assign-once and can be accessed as such.
>         * any struct dentry instance belongs to the same superblock throu=
gh
> the entire lifetime; ->d_sb is assign-once and can be accessed as such.  =
If it's
> postive, the corresponding inode will belong to the same superblock.
>         * any struct mount instance is associated with the same superbloc=
k
> through the entire lifetime; ->mnt_sb is assign-once and can be accessed =
as such.
>         * any opened file is associated with the same dentry and mount th=
rough
> the entire lifetime; mount and dentry are from the same superblock.
>
> Exclusion that would required to cope with the possibility of the above
> being violated would cost far too much, and that's without going into the
> amount of analysis needed to make sure that things wouldn't break.
>
> Which filesystem do you have in mind?

The following code use sget* with test functions today:
afs, btrfs, ceph, fuse, gfs2, nfs, ubifs, smb/client
... which means that they can share superblocks.

If those test functions use mount options to decide whether to share a
superblock (at least nfs and smb clients do this), those mount options
can change during remount.
At this point, the filesystems do not even have visibility into other
mounts that share the superblock. Hence they cannot even fail such
remounts.
Side effect of such remounts is that changes to mount options will
apply to all mounts that share the superblock, whether the user
intended to do that or not.

--=20
Regards,
Shyam

