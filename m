Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5521FE96F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 05:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFRDdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 23:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFRDdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:33:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C2C06174E;
        Wed, 17 Jun 2020 20:33:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g28so4335199qkl.0;
        Wed, 17 Jun 2020 20:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoGq+FbHXhkUIYYO0cKkpjXlMzq0R7M8oWnjs3wd6/g=;
        b=B5STWmrxBQaJU3C0JXJqsqIqNABchqBvHBYWJcJ53FvHzMuMzfpnxUKD2u3BUQwnYs
         ZgcV7gsP+S51/zgaLJGYFIRQLK9lqV9vD8K/SVxJ9RIYDXPIOUs9sKPguYQzy2vvv6mv
         4Qt1RexZ+zfC1hFJEdxUPfZdKP0su8EqAc0JEhlIsOcvHkTpriWdfZz9vcpVKCpwTM8F
         cKmSHuux2Y4LVYW9heh2d6GDKdD8jvasnPGxeIdhFjm5aBIT/Nnyf5x1uVWITx9A67Wm
         TIRliwVtw7WtpFaSNVd6HTeuNuSYQt6Bnh84QesHmMPnh7Gbjrp9rplcfLRickPYhHIp
         w8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OoGq+FbHXhkUIYYO0cKkpjXlMzq0R7M8oWnjs3wd6/g=;
        b=akFAvzoj+6wSK4zBpCHT7gV8LRT9FlPtnCQNTepM5xlX9kpX3bHxwsHZsenUlPOuWT
         462coWllRUlu0Gbd3yf3o9URjrbb9RS0ln4RsO4IjDpLTs8Fg7fuQ9y+GwNRu9Rfjkvf
         vdCQc/9OyhPVRlIPdAcNJtxZYI87dr3c/kvKsjEGHTPa5/+mRLNkcDp7RCqtuzvI+Kt8
         XTYOiDUx6YWPmzo7lTrGd+iUPjIlNQdxCNYdpl8s2uSDZBXMHBebsn6HJsZOfjsltB4Z
         OTiKBvk7rfzS28EabOUkyExpPZEcLyykb2bxV66N3fQYxcGCm+ujhy9d+CvdTHIvhZQv
         pPIQ==
X-Gm-Message-State: AOAM533i3MB6yXQyDNT5b/ArBR+LUQJ9uH6Og9Gt+e962mRr9rRX8Co8
        ibRf4At/Nv+rWk3pKtfV4w==
X-Google-Smtp-Source: ABdhPJxP7wNoRACtNB32MUkgM+XF1uBwJq7g9VkCrGQRyKbOkBnQMUNHGX2taLMbOj0zYoce2SdIzw==
X-Received: by 2002:a37:985:: with SMTP id 127mr1881135qkj.297.1592451216003;
        Wed, 17 Jun 2020 20:33:36 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id z46sm589913qtb.57.2020.06.17.20.33.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 20:33:35 -0700 (PDT)
Date:   Wed, 17 Jun 2020 23:33:33 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200618033333.py7dikfbu6sryzjd@gabell>
References: <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618014429.GS11245@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618014429.GS11245@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:44:29PM -0700, Darrick J. Wong wrote:
> On Wed, Jun 17, 2020 at 09:30:26PM -0400, Masayoshi Mizuma wrote:
> > On Wed, Jun 17, 2020 at 02:45:07PM -0400, J. Bruce Fields wrote:
> > > On Wed, Jun 17, 2020 at 01:28:11PM -0500, Eric Sandeen wrote:
> > > > but mount(8) has already exposed this interface:
> > > > 
> > > >        iversion
> > > >               Every time the inode is modified, the i_version field will be incremented.
> > > > 
> > > >        noiversion
> > > >               Do not increment the i_version inode field.
> > > > 
> > > > so now what?
> > > 
> > > It's not like anyone's actually depending on i_version *not* being
> > > incremented.  (Can you even observe it from userspace other than over
> > > NFS?)
> > > 
> > > So, just silently turn on the "iversion" behavior and ignore noiversion,
> > > and I doubt you're going to break any real application.
> > 
> > I suppose it's probably good to remain the options for user compatibility,
> > however, it seems that iversion and noiversiont are useful for
> > only ext4.
> > How about moving iversion and noiversion description on mount(8)
> > to ext4 specific option?
> > 
> > And fixing the remount issue for XFS (maybe btrfs has the same
> > issue as well)?
> > For XFS like as:
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 379cbff438bc..2ddd634cfb0b 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1748,6 +1748,9 @@ xfs_fc_reconfigure(
> >                         return error;
> >         }
> > 
> > +       if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
> > +               mp->m_super->s_flags |= SB_I_VERSION;
> > +
> 
> I wonder, does this have to be done at the top of this function because
> the vfs already removed S_I_VERSION from s_flags?

Ah, I found the above code doesn't work...
sb->s_flags will be updated after reconfigure():

int reconfigure_super(struct fs_context *fc)
{
...
        if (fc->ops->reconfigure) {
                retval = fc->ops->reconfigure(fc);
                if (retval) {
                        if (!force)
                                goto cancel_readonly;
                        /* If forced remount, go ahead despite any errors */
                        WARN(1, "forced remount of a %s fs returned %i\n",
                             sb->s_type->name, retval);
                }
        }

        WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
                                 (fc->sb_flags & fc->sb_flags_mask)));

Here, fc->sb_flags_mask should be MS_RMT_MASK, so SB_I_VERSION will be
dropped except iversion mount opstion (MS_I_VERSION) is set.

- Masa
