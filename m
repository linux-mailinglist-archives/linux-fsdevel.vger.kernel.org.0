Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92734078AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhIKOOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Sep 2021 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhIKOOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:14:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD713C061574;
        Sat, 11 Sep 2021 07:13:06 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q3so6093615iot.3;
        Sat, 11 Sep 2021 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KitDvTgcF8u5GUzxtRCOLjBDXdumB14NC4UdDO66+0=;
        b=ftiR8acCLqtMEpLFJNcJWjtTWpPrgVx5obVuTzMCc15w/c3NXSp253sFcgApcZsdp+
         PanwYjUmW/DNR+gtOjW+zIHekRzuJl+Vk+fzKsFs++1FNHqJcBVFeRRDY0zGgI/dMNaP
         FpBp6UNIUbW/ICm6vWfxtBPwRyN3GnLpGIP90v0iZ+q0AI+5DTAlKhmk4wvroeFZvqSc
         mCsuQA+EKBIE4ZHRvq43rVjjlyMa8WJuHVHtLq8/XpSZ3lxFbRifLWc6GTy7of9bWEFJ
         DDKThCVkAa/EOIZc0L7MbeZDeel1bL4CoMdegmyxzJGMcWnvNQHA+bAziLAR4rXVoUEV
         KRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KitDvTgcF8u5GUzxtRCOLjBDXdumB14NC4UdDO66+0=;
        b=mbtbK+yOdXYXAfaTma4B1nYILw9+y3NaruaRIPUyujEOSw7Uqihj6Szegc00xKpAO+
         apG4euiqh/XsOOVO5ptGKOgv5OYOwtBFwYR6YCsOzMzY8goll4V6K/lpESOS+CrcOTnj
         6QMN09dmmNQ05Fz4qLjWXxK4cigLGlG/BHbX3srj1lLdoB7q8XC8uvQA0KlbIuIG2B8P
         OC90UEUidNw9vUdYnmIHSqqlKrnIUXdM7SM5xQx+7/k4CethDVIOMFQeWq1LSSLlC3Ii
         iUx3yLx6SMTtc+emUHcdsupW2kZqt2OhBZsH2Cu35Lj0kqmZmu3arNEn05L90vrmy98h
         0VPg==
X-Gm-Message-State: AOAM533WwHV7R1LCM8EZIkdPhFel8nsvIYeh0X+6UXi3e+zNVRwEPMoB
        WUIGPKDAXEOXx8UiThNHfJQnb7nO4sWFRthwGCg=
X-Google-Smtp-Source: ABdhPJzSRNNh9eOYNfuvbfpJ7B6UC0An+cy+d0vnELkwZrexWaJCOnNKAw/RE8heFK4mHTYTtvn+6kfADWA1cYFmOa0=
X-Received: by 2002:a6b:610e:: with SMTP id v14mr2085382iob.70.1631369586148;
 Sat, 11 Sep 2021 07:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org> <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org> <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org> <20210901152251.GA6533@fieldses.org>
 <163055605714.24419.381470460827658370@noble.neil.brown.name>
 <20210905160719.GA20887@fieldses.org> <163089177281.15583.1479086104083425773@noble.neil.brown.name>
In-Reply-To: <163089177281.15583.1479086104083425773@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 11 Sep 2021 17:12:54 +0300
Message-ID: <CAOQ4uxjbjkqEEXTe7V4vaUUM1gyJwe6iSAaz=PdxJyU2M14K-w@mail.gmail.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
To:     NeilBrown <neilb@suse.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Maybe what we really need is for a bunch of diverse filesystem
> developers to get together and agree on some new common interface for
> subvolume management, including coming up with some sort of definition
> of what a subvolume "is".

Neil,

Seeing that LSF/MM is not expected to gather in the foreseen future, would
you like to submit this as a topic for discussion in LPC Filesystem MC [1]?
I know this is last minute, but we've just extended the CFP deadline
until Sep 15 (MC is on Sep 21), so if you post a proposal, I think we will
be able to fit this session in the final schedule.

Granted, I don't know how many of the stakeholders plan to attend
the LPC Filesystem MC, but at least Josef should be there ;)

I do have one general question about the expected behavior -
In his comment to the LWN article [2], Josef writes:

"The st_dev thing is unfortunate, but again is the result of a lack of
interfaces.
 Very early on we had problems with rsync wandering into snapshots and
 copying loads of stuff. Find as well would get tripped up.
 The way these tools figure out if they've wandered into another file system
 is if the st_dev is different..."

If your plan goes through to export the main btrfs filesystem and
subvolumes as a uniform st_dev namespace to the NFS client,
what's to stop those old issues from remerging on NFS exported btrfs?

IOW, the user experience you are trying to solve is inability of 'find'
to traverse the unified btrfs namespace, but Josef's comment indicates
that some users were explicitly unhappy from 'find' trying to traverse
into subvolumes to begin with.

So is there really a globally expected user experience?
If not, then I really don't see how an nfs export option can be avoided.

Thanks,
Amir.

[1] https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconferences#cont-filesys
[2] https://lwn.net/Articles/867509/
