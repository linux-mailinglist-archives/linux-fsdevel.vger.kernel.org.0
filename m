Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE05262EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380659AbiEMNSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380677AbiEMNS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 09:18:29 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE021E3CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:18:21 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c8so6619547qvh.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7DVFy8B/48vjDiogKao/u1m+Uh2mcMVRQSudVGyqLtY=;
        b=DjE88+L1q+zLlBpMSt37mMdN0+dUyQIzezAEtT4kgPMj+5SSNbCLHGx1qdXFtWUJE+
         zXSJMwHYSspilh8NQ9wqgl7tZR54EETX1g1p/cBR1GTZpCZNzomL6sQj4jIHUhlXb4jM
         uX6k2sbt6KYlxvGiJLl00l+MTg1ARkJHFtDW//qzXXIFo2ysalC44xvAtq8bBzpnveVc
         XAnVdv8i/OIWlB9cpKcwf5WhkQYUwG3j3KfzZT9nTpi0JyM+8zP8gkRmKXpI7QWqMwVU
         64Rxmf6dO1+vjGI9VQ1QyI58A6/84fj1zzNoWyjOnPLEuglLpIa9VElSi4ty3zMGOo5O
         YN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7DVFy8B/48vjDiogKao/u1m+Uh2mcMVRQSudVGyqLtY=;
        b=pxe9H3fp5nm5oXXfPH4b1m6LxovEWGAH65PYvqDSiPWL2YUWfjoyeThb0RIPheGbKf
         aYLremA5gyjkQtXD2GPwpN7s3WVEV9po26DUqSUmAISRilA0AUcplOP+w3fAKN5zWZPD
         42Ugp2CtCLhEp+XZyv5pBNiejD0mXKi7F5/zjqBbuiPD+TLDoDIYkhPa12NclY9ghjYp
         eEdkNARvvsIi+XQFMNspnz/KcA5ovlmygyYgOv2mC2DA0kBAJnLTENPhAO/HsLWjGgLD
         fHwaaJZEhYAf6lSsd0V8GL0bLLM2KAsqsOO1rvPeeJ6KmXgFwMDVr/4Uz/CC7CWhFI8B
         hqqQ==
X-Gm-Message-State: AOAM5313nSNrm7gViQdiups5jWn6Hs9yrdtnewCNzE/2uuJh7wqiyCqa
        aGw+iWVkMYDn8MMJ/hW3eXix0UOfk04X0Crb
X-Google-Smtp-Source: ABdhPJyomolJRYnpMEQULCStjOkEvGo2Qh31RUDyghNdXG/oPYiAqPkyU1f8MsaTLrLM6vktlh87kA==
X-Received: by 2002:a0c:f453:0:b0:45a:95a5:e81d with SMTP id h19-20020a0cf453000000b0045a95a5e81dmr4173656qvm.48.1652447900046;
        Fri, 13 May 2022 06:18:20 -0700 (PDT)
Received: from google.com (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
        by smtp.gmail.com with ESMTPSA id j9-20020ac84409000000b002f3edca00casm1420178qtn.16.2022.05.13.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:18:18 -0700 (PDT)
Date:   Fri, 13 May 2022 13:18:15 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <Yn5al/rEQIcf6pjR@google.com>
References: <YnOmG2DvSpvvOEOQ@google.com>
 <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
 <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
 <20220506100636.k2lm22ztxpyaw373@quack3.lan>
 <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 07:03:13PM +0300, Amir Goldstein wrote:
> Sorry Matthew, I was looking at the code to give you pointers, but there were
> so many subtle details (as Jan has expected) that I could only communicate
> them with a patch.
> I tested that this patch does not break anything, but did not implement the
> UAPI changes, so the functionality that it adds is not tested - I leave that
> to you.

No, that's totally fine. I had to familiarize myself with the
FS/FAN_RENAME implementation as I hadn't gone over that series. So
appreciate you whipping this together quickly as it would've taken a
fair bit of time.

Before the UAPI related modifications, we need to first figure out how
we are to handle the CREATE/DELETE/MOVE cases.

...

> My 0.02$ - while FAN_RENAME is a snowflake, this is not because
> of our design, this is because rename(2) is a snowflake vfs operation.
> The event information simply reflects the operation complexity and when
> looking at non-Linux filesystem event APIs, the event information for rename
> looks very similar to FAN_RENAME. In some cases (lustre IIRC) the protocol
> was enhanced at some point exactly as we did with FAN_RENAME to
> have all the info in one event vs. having to join two events.
> 
> Hopefully, the attached patch simplifies the specialized implementation
> a little bit.
> 
> But... (there is always a but when it comes to UAPI),
> When looking at my patch, one cannot help wondering -
> what about FAN_CREATE/FAN_DELETE/FAN_MOVE?
> If those can report child fid, why should they be treated differently
> than FAN_RENAME w.r.t marking the child inode?

This is something that crossed my mind while looking over the patch
and is a very good thing to call-out indeed. I am of the opinion that
we shouldn't be placing FAN_RENAME in the special egg basket and also
consider how this is to operate for events
FAN_CREATE/FAN_DELETE/FAN_MOVE.

> For example, when watching a non-dir for FAN_CREATE, it could
> be VERY helpful to get the dirfid+name of where the inode was
> hard linked.

Oh right, here you're referring to this specific scenario:

- FAN_CREATE mark exclusively placed on /dir1/old_file
- Create link(/dir1/old_file, /dir2/new_file)
- Expect to receive single event including two information records
  FID(/dir1/old_file) + DFID_NAME(/dir2/new_file)

Is that correct?

> In fact, if an application is watching FAN_RENAME to track the
> movement of a non-dir file and does not watch hardlink+unlink, then
> the file could escape under the application's nose.

That's understood.

/M

