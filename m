Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E22636317
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 16:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiKWPQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 10:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiKWPQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:16:37 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB78CF24
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 07:16:36 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id d185so17778255vsd.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 07:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfI1bSmJwxZ8E8JJctQ0kdIuqLE/rz90cNSezybkcc0=;
        b=F+vbxEgf6at1XjQpgMn7t7oEe25HbEyPaQxCtR79g1KQdgLc/vbKA4MbxHEHmj0wRe
         QRTsspBkm7rVSo8FtcLfXfOIwmtZtuFgmWe+LiHGzB45vFPQaXKoDj1n/kN3X9Kfe7Ch
         qDK2YOys1uUOBMa2CD2XIZR+SPs7GBuxwE3SRRdr2qzVigSarbtMeNZW3ZbAMjRnRgpj
         bheYTDBz8wzJ9m7OiNEmUEoh/PyxPhtYFi6aEcUSQPDe2TE/8E6OP1EU06mku5l3Q4K9
         bQHeT0SSvs7YU1VAivnhE1Bp0A+x9rWNZk/783sAoe9MZwXCvVRIxHGvfh+vVs1TowEX
         QC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfI1bSmJwxZ8E8JJctQ0kdIuqLE/rz90cNSezybkcc0=;
        b=Pq59IKqZ2/sraX9LjCJKohCt/HQwlyC2JYWFVNEdPj9iKD+5JMFaEkWVtey55TrgBx
         EIsRYGgS67psA76ioR9DzOFek5iIrJB4/pt/oLcXBSKHPFU+BYRBchGmDBqlTgT7X8jC
         Loiq2DqsuG0WcIWvC6Fuwn8ul9Hz51GjgA3reBkVINAkn4Sgy24OxzW99rLCjhndedRx
         4kmsMPgCmC8SDpRRj246x+uBe27BQaiqwEH2EIyx565ruxRxkAEzHmq54Agw/54rbW1/
         8by71i0u/yxNBCwDPbeX9kFkWhyqhjbGCy0FGDrC/pQFFlxHewjdPhOn5P7KTgbQGSBI
         VXyA==
X-Gm-Message-State: ANoB5pkNaC5kmI/Qmay2p1izraLH+ePPt8gPuvrVBaF+ZCuqLu7IUVTz
        ttHaZElKWIsRi+gB5UEkRt+88AIsEt332650Fv7hEImN6Jw=
X-Google-Smtp-Source: AA0mqf631X3ZIwz5xrVAYOt7C5HxY8M+dxu0GeFDV6mqdN04zUysBWFt62UjYAKHaRZ6NxUl4Stwo/PBGRh1PxCBAl0=
X-Received: by 2002:a05:6102:2323:b0:3b0:6f73:d0bb with SMTP id
 b3-20020a056102232300b003b06f73d0bbmr1604853vsa.71.1669216595252; Wed, 23 Nov
 2022 07:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20221103163045.fzl6netcffk23sxw@quack3> <CAOQ4uxhRYZgDSWr8ycB3hqxZgg6MWL65eP0eEkcZkGfcEpHpCg@mail.gmail.com>
 <20221107111008.wt4s4hjumxzl5kqj@quack3> <CAOQ4uxhjCb=2f_sFfx+hn8B44+vgZgSbVe=es4CwiC7dFzMizA@mail.gmail.com>
 <20221114191721.yp3phd5w5cx6nmk2@quack3> <CAOQ4uxiGD8iDhc+D_Qse_Ahq++V4nY=kxYJSVtr_2dM3w6bNVw@mail.gmail.com>
 <20221115101614.wuk2f4dhnjycndt6@quack3> <CAOQ4uxhcXKmdq+=fexuyu-nUKc5XHG6crtcs-+tP6-M4z357pQ@mail.gmail.com>
 <20221116105609.ctgh7qcdgtgorlls@quack3> <CAOQ4uxhQ2s2SOkvjCAoZmqNRGx3gyiTb0vdq4mLJd77pm987=g@mail.gmail.com>
 <20221123101021.7a65fgjop3d45ryq@quack3>
In-Reply-To: <20221123101021.7a65fgjop3d45ryq@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Nov 2022 17:16:23 +0200
Message-ID: <CAOQ4uxg0hfuyQk3dBXfF2VTtfyOg5bD_NPrz0VOSFuVoA4vpuw@mail.gmail.com>
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

On Wed, Nov 23, 2022 at 12:10 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 16-11-22 18:24:06, Amir Goldstein wrote:
> > > > Why then give up on the POST_WRITE events idea?
> > > > Don't you think it could work?
> > >
> > > So as we are discussing, the POST_WRITE event is not useful when we want to
> > > handle crash safety. And if we have some other mechanism (like SRCU) which
> > > is able to guarantee crash safety, then what is the benefit of POST_WRITE?
> > > I'm not against POST_WRITE, I just don't see much value in it if we have
> > > another mechanism to deal with events straddling checkpoint.
> > >
> >
> > Not sure I follow.
> >
> > I think that crash safety can be achieved also with PRE/POST_WRITE:
> > - PRE_WRITE records an intent to write in persistent snapshot T
> >   and add to in-memory map of in-progress writes of period T
> > - When "checkpoint T" starts, new PRE_WRITES are recorded in both
> >   T and T+1 persistent snapshots, but event is added only to
> >   in-memory map of in-progress writes of period T+1
> > - "checkpoint T" ends when all in-progress writes of T are completed
>
> So maybe I miss something but suppose the situation I was mentioning few
> emails earlier:
>
> PRE_WRITE for F                 -> F recorded as modified in T
> modify F
> POST_WRITE for F
>
> PRE_WRITE for F                 -> ignored because F is already marked as
>                                    modified
>
>                                 -> checkpoint T requested, modified files
>                                    reported, process modified files
> modify F
> --------- crash
>
> Now unless filesystem freeze or SRCU is part of checkpoint, we will never
> notify about the last modification to F. So I don't see how PRE +
> POST_WRITE alone can achieve crash safety...
>
> And if we use filesystem freeze or SRCU as part of checkpoint, then
> processing of POST_WRITE events does not give us anything new. E.g.
> synchronize_srcu() during checkpoing before handing out list of modified
> files makes sure all modifications to files for which PRE_MODIFY events
> were generated (and thus are listed as modified in checkpoint T) are
> visible for userspace.
>
> So am I missing some case where POST_WRITE would be more useful than SRCU?
> Because at this point I'd rather implement SRCU than POST_WRITE.
>

I tend to agree. Even if POST_WRITE can be done,
SRCU will be far better.

> > The trick with alternating snapshots "handover" is this
> > (perhaps I never explained it and I need to elaborate on the wiki [1]):
> >
> > [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Modified_files_query
> >
> > The changed files query results need to include recorded changes in both
> > "finalizing" snapshot T and the new snapshot T+1 that was started in
> > the beginning of the query.
> >
> > Snapshot T MUST NOT be discarded until checkpoint/handover
> > is complete AND the query results that contain changes recorded
> > in T and T+1 snapshots have been consumed.
> >
> > When the consumer ACKs that the query results have been safely stored
> > or acted upon (I called this operation "bless" snapshot T+1) then and
> > only then can snapshot T be discarded.
> >
> > After snapshot T is discarded a new query will start snapshot T+2.
> > A changed files query result includes the id of the last blessed snapshot.
> >
> > I think this is more or less equivalent to the SRCU that you suggested,
> > but all the work is done in userspace at application level.
> >
> > If you see any problem with this scheme or don't understand it
> > please let me know and I will try to explain better.
>
> So until now I was imagining that query results will be returned like a one
> big memcpy. I.e. one off event where the "persistent log daemon" hands over
> the whole contents of checkpoint T to the client. Whatever happens with the
> returned data is the bussiness of the client, whatever happens with the
> checkpoint T records in the daemon is the daemon's bussiness. The model you
> seem to speak about here is somewhat different - more like readdir() kind
> of approach where client asks for access to checkpoint T data, daemon
> provides the data record by record (probably serving the data from its
> files on disk), and when the client is done and "closes" checkpoint T,
> daemon's records about checkpoint T can be erased. Am I getting it right?
>

Yes, something like that.
The query result (which is actually a recursive readdir) could be huge.
So it cannot really be returned as a blob, it must be steamed to consumers.

> This however seems somewhat orthogonal to the SRCU idea. SRCU essentially
> serves the only purpose - make sure that modifications to all files for
> which we have received PRE_WRITE event are visible in respective files.
>

Absolutely right.
Sorry for the noise, but at least you've learned one more thing
about my persistent change snapshots architecture ;-)

Thanks,
Amir.
