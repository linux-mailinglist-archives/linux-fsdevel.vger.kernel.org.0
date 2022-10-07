Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04625F7951
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJGN6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJGN6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:58:38 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87193CAE78
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 06:58:33 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id l127so5110280vsc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jCSk+G0cFp046ENaCMjY1tj8PaqTh0kkUHLyrVImswE=;
        b=f/yhQELSdgiXsu21+IqMshvVKBYa9wBY3N0E/ma6yWDMnjlL4PDcho41mvjEuXis8u
         DG3mCxQc187rd3vTqxiskIvgyZZQ5Boxb+wYnjjH34wlS7bVpaevpkUznK4hTe9znjCe
         4/38giuKYsM/CG8ywFSEzJH40yiHtQqICHXFU1B7ho62wdF7hlKUoBqPTTtlU4ptC3wf
         esx3qUnf5ahUcvJ/eln+HUHlhrEnkDz8N9pcFVxQgJJmGboJmvvs1EyrtGhuo+VQtmL2
         6D2RM4hMZ46AhverXdEBlGx7pEP5CBhnu1Lk228PdZjptEhPoIDbqirtCC1QSdXttGdr
         DoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCSk+G0cFp046ENaCMjY1tj8PaqTh0kkUHLyrVImswE=;
        b=yt9pQ0eSrAYiYfnkSZlp54b4Wi1P9blpMWF3yrvHTC7E+6WkaeHAiFe1jjgikGHNrD
         jmhqZYUWtJJwwMXsmReBHkoz7bpSHQx05bJa5siN8YGEMp9xtpVeqZLJ+NwJE2sQhyxC
         vXNYfqAfUgDamD26BPLx548364PCZorou59otLqK8korE38zq1GEH1FVtaosp0KZgJqG
         xSVOevkDomttpghky0iT6tlwmnHFo5LClFH9omOsMr1wDRE+ANu0jfuMcgVRCN9C0Ssb
         YMsT7VvFYr9xW3wDQ046nHQ1m/MgAxrge3RhYKRVArbSp5Gb1imvSMK5/eN1VTcuIFPU
         UCWQ==
X-Gm-Message-State: ACrzQf03GertktyxXgOMr8BeE9lCQR0TghYF+VLwsMW3+kN/HG+gMLmq
        V4Vle5PIbYxQIo6ok1ZsMCZvmXuoxfDUYVq16Pw=
X-Google-Smtp-Source: AMsMyM4vM6olU6QvL8xNyxo3el3UP3Dj8t1s5BCcGQvOvbCW13cZBQpPHyexht9jw6jT16APYHtv5Ud0Nsu8ILPsr8o=
X-Received: by 2002:a67:c099:0:b0:39b:342:3c0d with SMTP id
 x25-20020a67c099000000b0039b03423c0dmr2805903vsi.3.1665151112626; Fri, 07 Oct
 2022 06:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3> <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
 <20220929100145.wruxmbwapjn6dapy@quack3>
In-Reply-To: <20220929100145.wruxmbwapjn6dapy@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 7 Oct 2022 16:58:21 +0300
Message-ID: <CAOQ4uxjAn50Z03SysRT0v8AVmtvDHpFUMG6_TYCCX_L9zBD+fg@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[reducing CC]

> > The other use case of automatic inode marks I was thinking about,
> > which are even more relevant for $SUBJECT is this:
> > When instantiating a dentry with an inode that has xattr
> > "security.fanotify.mask" (a.k.a. persistent inode mark), an inode
> > mark could be auto created and attached to a group with a special sb
> > mark (we can limit a single special mark per sb).
> > This could be implemented similar to get_acl(), where i_fsnotify_mask
> > is always initialized with a special value (i.e. FS_UNINITIALIZED)
> > which is set to either 0 or non-zero if "security.fanotify.mask" exists.
> >
> > The details of how such an API would look like are very unclear to me,
> > so I will try to focus on the recursive auto inode mark idea.
>
> Yeah, although initializing fanotify marks based on xattrs does not look
> completely crazy I can see a lot of open questions there so I think
> automatic inode mark idea has more chances for success at this point :).

I realized that there is one sort of "persistent mark" who raises
less questions - one that only has an ignore mask.

ignore masks can have a "static" namespace that is not bound to any
specific group, but rather a set of groups that join this namespace.

I played with this idea and wrote some patches:
https://github.com/amir73il/linux/commits/fan_xattr_ignore_mask

This may end up being useful in the HSM POC - i.e., HSM places
persistent ignore mask for permission events for populated dirs/files
and removes the persistent mask before punching a hole.

Haven't forgotten about the promised wiki.
For now, I just wanted to share this idea.

Thanks,
Amir.
