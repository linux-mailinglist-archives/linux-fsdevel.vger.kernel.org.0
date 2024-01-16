Return-Path: <linux-fsdevel+bounces-8026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2B82E7AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 02:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0B01C22CDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86957333;
	Tue, 16 Jan 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ACMwnKx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702A6FC8;
	Tue, 16 Jan 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705367390; bh=DCpBVg+aQyT3L+Kdy97dklgtgdBCPPQELOohdN2IBLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACMwnKx8OkePAo+TKkh4mm6VLRW+bwd3znbVNaqB5AKe72gorFllQqcdy96Ni/xPB
	 wP/Mm6sYlsJN3YldUyZXdGwE4u/tva+fdY2mJmmuzCzWeDW7DcCNAjwIoW7pzSIim6
	 RXmflkXYt0ubQpdqfksJ5ItJKEDxw+O63axATAGA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 26E31ED2; Tue, 16 Jan 2024 09:09:46 +0800
X-QQ-mid: xmsmtpt1705367386t9z3vls8a
Message-ID: <tencent_29BA3BBBE933849E2C1B404BE21BA525FB08@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25t/i5xDARED5DFubYiZPfDhGJ1pTdWxzL7vQ4ffXDKzsES3yFW87
	 5Vt/xVbjPBm9GcMfJtspWmJSTFYrIGXGlUpjvs88aUaWIKLpUTBB2p0vEtnigSRWZ5XZi2blXijN
	 +m820GKQgqIjJT4n9O0Apgq0ACVXVjW9yBvf0aoarXaaPnlWCn8wZtLSPLT1K34GqBlxCGSzXNqZ
	 VijDbRMlsdjetKemCP+25+ncH6Wz2Q+CEdga7Ffn0ODPUko6lAaFL1pA5mbp0zFJELydIyXRwjw8
	 wxvl8KPVTqnUQOMuyhQXX87xYF2QQZc/jPWH1gGNYgfiVkM1/R34xY1Dq2hEZVPgWcyoIGsga7WE
	 p/xqJEn+LwB5iUAW1hfCJQB7b9KORLXYJihBbcMvvIVbrJoFdXfyxgATy3y/jXXB1XWjLHtp/K9g
	 aDLyu2zCIGAQ+EHAaNZZWFShDQgx3jtDRH4phaMa3fBSiQGOhP0pRbnaSD/n39TyhxMZf7kiZQdO
	 beg7RLrOsXPOcHwzL0nkfPVvKOhO/i2hmYlHsSD9n5208v1IdoTyagAMwp8ph0akQyVUl+ZrLHit
	 7ScVjzZdmULr85wGj0j9nip/SNr8ZRXHEERwLA5/na1DKWdgR4VF95HRVzMM6mhiH8uvJRMRQYjY
	 bmeAtPbOSauv+gE/iLLT9JHMgX92GwVQKRPSGH1X8GEEKdrxjU24hfKi5vPMSg4hD2qik7OeOpde
	 ahAZIMSbDV2wLcZkhYRfnGyZ92/X0lnd9AizHsDJ4G7y6YcUR3TtbvZvEBCfIeiEhnh0KuI51Mld
	 3ioHVAdM3EQ9D5vm+LODJAlZoT/oqvNkQ+ukqaYNN60R44rTUG0MxCy7eDLwGwsadzmtPETstnmh
	 b/iu79xrQo7P2nLt6Vg7veqeGFXmhWpj4x6aNZ9a28WZ/vsZFLw7YoG/OR8FMxszZubV9vXXZ7J8
	 L8LgKtf7DQLM7dI2ZA+YWGrk8u1+iABcK5zAE6Hcc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: dsterba@suse.cz
Cc: clm@fb.com,
	daniel@iogearbox.net,
	dsterba@suse.com,
	eadavis@qq.com,
	john.fastabend@gmail.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujian56@huawei.com,
	syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 16 Jan 2024 09:09:47 +0800
X-OQ-MSGID: <20240116010946.58705-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115190824.GV31555@twin.jikos.cz>
References: <20240115190824.GV31555@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 20:08:25 +0100, David Sterba wrote:
> > > If ioctl does not pass in the correct tgtdev_name string, oob will occur because
> > > "\0" cannot be found.
> > >
> > > Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  fs/btrfs/dev-replace.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > > index f9544fda38e9..e7e96e57f682 100644
> > > --- a/fs/btrfs/dev-replace.c
> > > +++ b/fs/btrfs/dev-replace.c
> > > @@ -730,7 +730,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
> > >  int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> > >  			    struct btrfs_ioctl_dev_replace_args *args)
> > >  {
> > > -	int ret;
> > > +	int ret, len;
> > >
> > >  	switch (args->start.cont_reading_from_srcdev_mode) {
> > >  	case BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS:
> > > @@ -740,8 +740,10 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	len = strnlen(args->start.tgtdev_name, BTRFS_DEVICE_PATH_NAME_MAX + 1);
> > >  	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
> > > -	    args->start.tgtdev_name[0] == '\0')
> > > +	    args->start.tgtdev_name[0] == '\0' ||
> > > +	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)
> >
> > I think srcdev_name would have to be checked the same way, but instead
> > of strnlen I'd do memchr(name, 0, BTRFS_DEVICE_PATH_NAME_MAX). The check
> > for 0 in [0] is probably pointless, it's just a shortcut for an empty
> > buffer. We expect a valid 0-terminated string, which could be an invalid
> > path but that will be found out later when opening the block device.
> 
> Please let me know if you're going to send an updated fix. I'd like to
> get this fixed to close the syzbot report but also want to give you the
> credit for debugging and fix.
> 
> The preferred fix is something like that:
> 
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -741,6 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
>         if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
>             args->start.tgtdev_name[0] == '\0')
>                 return -EINVAL;
> +       args->start.srcdev_name[BTRFS_PATH_NAME_MAX] = 0;
> +       args->start.tgtdev_name[BTRFS_PATH_NAME_MAX] = 0;
This is not correct,
1. The maximum length of tgtdev_name is BTRFS_DEVICE_PATH_NAME_MAX + 1
2. strnlen should be used to confirm the presence of \0 in tgtdev_name
3. Input values should not be subjectively updated
4. The current issue only involves tgtdev_name
> 
>         ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
>                                         args->start.srcdevid,


