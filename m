Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C684CB3AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiCCAaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 19:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCCAaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:30:21 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8AE4FC6F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 16:29:36 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c7so2747705qka.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 16:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ETM+Zu622nDqVa3wz+osL6CiDEUlv57g1pg0q6yBmFs=;
        b=1cVjwE4vryVzO1VUWJHcv42VskLLZjk0RsqPoeURS2jD7Uxvwz6pQIVXxlwysIk2P+
         sKDKbeU4gOZm6AIwCT15S8A1zrNeXV9ouyjHz2tRsR6cvr5B1ntLqqCAwNv6ERiQWFCT
         /islPG8S+hCZ7lvveaZjL1vC57gnghbBzl4DznRjFFxzj2RYpY9Pk6PFNIrZQcF7uMsj
         HT3UXTbP/ECCPSy65z1SiWUO2YA9z/UHYL6b39AyEFcVwIqgDV9Hq+8c2gPCKfSQ4rnk
         LeYWPKQm78CCvfcVL9x3QYyseJIuxjvtATbEH3nYeaM2LOC9We3f9Veek/QeZ0+piUFL
         3s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ETM+Zu622nDqVa3wz+osL6CiDEUlv57g1pg0q6yBmFs=;
        b=ZNI6AyoWUOQi7A8BUViRHL7BaJ7WXOMfcqSyMLi9MsjTJJUt2ba/BoSnkEo2g10Ppu
         lTNhoOzLCGxjiu8BCxj/h/GU28r3LKWlMKtyms4VrBxl/ixzHBaxTPvWm42oWMbe1R2G
         ea3Xo/+U4PdsUUEn2pjl+XlLngGew6NO5354Pl2X68SC8Cbw9mSsZhGEnLWuNanwiICB
         61dES1AO8rMV3MY1PgxhhZwc/3Uhpupv/a65La6wpW9ad/0pmpakD+AAqETufYEgtpnq
         liKMYrn/nbmKbsZdPOEtZVk3zdyeWqt71VwCHq6YgaYUgy/251ct7RZ07Ki/N/8abD1B
         0tzQ==
X-Gm-Message-State: AOAM530t4yMPCcAAeTQwE8cmyuGVJY3tXuAFVebYVozBBjAP6gjahjhC
        2tbB8v36xuiNqv2vu4Q/wf/WSFnfAj7EhFaA
X-Google-Smtp-Source: ABdhPJzoVMhT8D0gM/0LXP1xare2z7FtUCv+HsdrSWtLb6mAt893AwDDw4kA6s1FROaqoFOw8sWC/Q==
X-Received: by 2002:a37:9c92:0:b0:60d:d77e:e643 with SMTP id f140-20020a379c92000000b0060dd77ee643mr18108824qke.252.1646267375830;
        Wed, 02 Mar 2022 16:29:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c16-20020a05622a059000b002dc93dc92d1sm403829qtb.48.2022.03.02.16.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:29:35 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:29:34 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: nfs generic/373 failure after "fs: allow cross-vfsmount
 reflink/dedupe"
Message-ID: <YiAL7uNA3ZiaBCE6@localhost.localdomain>
References: <20220302065952.GE3927073@dread.disaster.area>
 <CAOQ4uxgU7cYAO+KMd=Yb8Fo4AwScQ2J0eqkYn3xWjzBWKtUziQ@mail.gmail.com>
 <20220302082658.GF3927073@dread.disaster.area>
 <CAOQ4uxgiL2eqx-kad+dddXvXPREKT-w3_BnLzdoJaJqGm=H=vA@mail.gmail.com>
 <20220302211226.GG3927073@dread.disaster.area>
 <20220302220450.GD10757@fieldses.org>
 <Yh/vADRGuPFGIEc+@localhost.localdomain>
 <20220302224250.GF10757@fieldses.org>
 <YiABiLtH/4nMJE+u@localhost.localdomain>
 <20220303000735.GA21944@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303000735.GA21944@fieldses.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 07:07:35PM -0500, J. Bruce Fields wrote:
> On Wed, Mar 02, 2022 at 06:45:12PM -0500, Josef Bacik wrote:
> > On Wed, Mar 02, 2022 at 05:42:50PM -0500, J. Bruce Fields wrote:
> > > On Wed, Mar 02, 2022 at 05:26:08PM -0500, Josef Bacik wrote:
> > > > On Wed, Mar 02, 2022 at 05:04:50PM -0500, J. Bruce Fields wrote:
> > > > > I started seeing generic/373 fail on recent linux-next in NFS testing.
> > > > > 
> > > > > Bisect lands it on aaf40970b1d0 "fs: allow cross-vfsmount
> > > > > reflink/dedupe".
> > > > > 
> > > > > The test fails because a clone between two mounts is expected to fail,
> > > > > and no longer does.
> > > > > 
> > > > > In my setup both mounts are nfs mounts.  They are mounts of different
> > > > > exports, and the exports are exports of different filesystems.  So it
> > > > > does make sense that the clone should fail.
> > > > > 
> > > > > I see the NFS client send a CLONE rpc to the server, and the server
> > > > > return success.  That seems wrong.
> > > > > 
> > > > > Both exported filesystems are xfs, and from the code it looks like the
> > > > > server calls vfs_clone_file_range(), which ends up calling
> > > > > xfs_file_remap_range().
> > > > > 
> > > > > Are we missing a check now in that xfs case?
> > > > > 
> > > > > I haven't looked any more closely at what's going on, so I could be
> > > > > missing something.
> > > > > 
> > > > 
> > > > Yeah there's a few fstests that test this functionality that need to be removed,
> > > > I have patches pending for this in our fstests staging tree (since we run
> > > > fstests nightly on our tree)
> > > > 
> > > > https://github.com/btrfs/fstests/tree/staging
> > > > 
> > > > Right now the patches just remove the tests from auto since that's what we run,
> > > > I'll remove them properly once the patch lands in linus.  Thanks,
> > > 
> > > So, out of curiosity, what is xfs doing in this case?  These are two
> > > filesystems on separate partitions, is it falling back on a read/write
> > > loop or something?
> > 
> > I don't think so?  I'm actually kind of confused, because nfsd does
> > vfs_clone_file_range, and the only place I messed with for CLONE was
> > ioctl_clone_file, so the patch changed literally nothing, unless you aren't
> > using nfsd for the server?
> > 
> > And if they are in fact two different file systems the i_sb != i_sb of the
> > files, so there's something pretty strange going on here, my patch shouldn't
> > affect your setup.  Thanks,
> 
> Sorry, took me a minute to understand, myself:
> 
> It's actually only the client behavior that changed.  Previously the
> client would reject an attempt to clone across filesystems, so the
> server never saw such a request.  After this patch, the client will go
> ahead and send the CLONE.  (Which, come to think of it, is probably the
> right thing for the client to do.)
> 
> So the server's probably always had a bug, and this just uncovered it.
> 
> I'd be curious what the consequences are.  And where the check should be
> (above or below vfs_clone_file_range()?).
> 

This is where I'm confused, this really shouldn't succeed

loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
                           struct file *file_out, loff_t pos_out,
                           loff_t len, unsigned int remap_flags)
{
        loff_t ret;

        WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);

        if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
                return -EXDEV;


loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
                            struct file *file_out, loff_t pos_out,
                            loff_t len, unsigned int remap_flags)
{
        loff_t ret;

        file_start_write(file_out);
        ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
                                  remap_flags);

And even if we get past here, I imagine XFS would freak out because it can't
find the extents (unless you're getting lucky and everything is lining up?).
I'm super confused...

Josef
