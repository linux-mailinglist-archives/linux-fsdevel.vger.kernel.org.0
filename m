Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735069C3ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 02:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBTBOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Feb 2023 20:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBTBN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Feb 2023 20:13:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA765B4;
        Sun, 19 Feb 2023 17:13:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o9-20020a05600c510900b003ddca7a2bcbso1104400wms.3;
        Sun, 19 Feb 2023 17:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRjv1bkYnEq8PdAJDpgJuFsrB4ud3uS5wRCFbiT5iD8=;
        b=cbH9mFQVTrOC29/GbdlJXo/AQr3SGruqH+xwp8DHSxYxAz3tN79PqJuYyI+UtsREXD
         cvlBFZ1ho44MO8U49jts4d8NWl1oZA9s1+0FrESgzdfV8x+U9Q+28QB5Qh1O52m8N7cY
         I0LoAIFaPwVvi1q/6remuBVdBJvAzziJgQ5JVb+R171JRET9dCL0iEtjMD4xIA9IKCjS
         z/st64UO0oaicE7LUAgEirwwKd8UxB36ss18C2QyLD2voU4fWoDK91GBeUABVYYEPO91
         luSP2a5bTzPGuwjemYXLy7rZbwJG86/eoervPJ8Dl5ayS0FF/cGUTphN/zcCd+VSTIiz
         ZmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRjv1bkYnEq8PdAJDpgJuFsrB4ud3uS5wRCFbiT5iD8=;
        b=jawn0U97j5IbxsQNUOmCb2v0UJtuVmfK25ZcxU7bADmTETjdem9Oez2ay79TvYHgDH
         xuovsdrlBb4zgoKP/J5uVMnytgVOTE5FvTjpZn2jUCZ+0ABP7E/y2F/UzzYpOtns/oQK
         2sSKzIHkZeW3pa4+GoDZHs/bHkSoUGBO6bG/IcDyjKcSkYsm37SbM9HVvL8xbg8DPWHR
         vMooudse39WA/u4PC/wab+nHBtcaFa4c6n0ia7Mlys17bPxE0pLaZAEU2bdokWG/CpNm
         0qKOp1PrrBMcoG2k1/I0upPUpb4ecsmTMlT3DRrk7H8caHEZORK7Rfye463rkdhC3DSq
         QHIQ==
X-Gm-Message-State: AO0yUKWEgIoTM9SLrynGnea2TQGIjQECaEXsuo6T0GlFMuCGL1Oifssr
        cYB/Vwm921r30fiUFJ1fboSEpGYJPQicrlBZ2dg=
X-Google-Smtp-Source: AK7set8s8+1kI9zVellxX/6p45rLGP4ylbKicP82dQHfUGRat1Q2jsKPYKoMYBxEyYeKNXe5MA26vTZ/QGeNekjfiQo=
X-Received: by 2002:a05:600c:198e:b0:3d9:fd0c:e576 with SMTP id
 t14-20020a05600c198e00b003d9fd0ce576mr386614wmq.6.1676855635571; Sun, 19 Feb
 2023 17:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-1-ericvh@kernel.org>
 <12241224.W6qpu7VSM5@silver>
In-Reply-To: <12241224.W6qpu7VSM5@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sun, 19 Feb 2023 19:13:44 -0600
Message-ID: <CAFkjPTmeAV2Qz95tY9OQOryZQoKKkDEorkaFMLQYPaJgog-1Kw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Performance fixes for 9p filesystem
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

Glad to hear bugs disappeared.  writeback having a different
performance than mmap is confusing as they should be equivalent.

The huge blocksize on your dd is an interesting choice -- it will
completely get rid of any impact of readahead.  To see impact of
readahead, choose a blocksize of
less than msize (like 4k) to actually see the perf of readahead.  The
mmap degradation is likely due to stricter coherence (open-to-close
consistency means we wait on writeout), but I'd probably need to go in
and trace to verify (which probably isn't a bad idea overall).
probably a similar situation for loose and writeback.  Essentially,
before close consistency it didn't have to wait for the final write to
complete before it returns so you see a faster time (even though data
wasn't actually written all the way through so you aren't measuring
the last little bit of the write (which can be quite large of a big
msize).

I'm going to take a pass through tomorrow making some fixups that
Dominiquee suggested and trying to reproduce/fix the fscache problems.

      -eric

On Sun, Feb 19, 2023 at 3:36 PM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Saturday, February 18, 2023 1:33:12 AM CET Eric Van Hensbergen wrote:
> > This is the fourth version of a patch series which adds a number
> > of features to improve read/write performance in the 9p filesystem.
> > Mostly it focuses on fixing caching to help utilize the recently
> > increased MSIZE limits and also fixes some problematic behavior
> > within the writeback code.
> >
> > All together, these show roughly 10x speed increases on simple
> > file transfers over no caching for readahead mode.  Future patch
> > sets will improve cache consistency and directory caching, which
> > should benefit loose mode.
> >
> > This iteration of the patch incorporates an important fix for
> > writeback which uses a stronger mechanism to flush writeback on
> > close of files and addresses observed bugs in previous versions of
> > the patch for writeback, mmap, and loose cache modes.
> >
> > These patches are also available on github:
> > https://github.com/v9fs/linux/tree/ericvh/for-next
> > and on kernel.org:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
> >
> > Tested against qemu, cpu, and diod with fsx, dbench, and postmark
> > in every caching mode.
> >
> > I'm gonna definitely submit the first couple patches as they are
> > fairly harmless - but would like to submit the whole series to the
> > upcoming merge window.  Would appreciate reviews.
>
> I tested this version thoroughly today (msize=512k in all tests). Good news
> first: the previous problems of v3 are gone. Great! But I'm still trying to
> make sense of the performance numbers I get with these patches.
>
> So when doing some compilations with 9p, performance of mmap, writeback and
> readahead are basically all the same, and only loose being 6x faster than the
> other cache modes. Expected performance results? No errors at least. Good!
>
> Then I tested simple linear file I/O. First linear writing a 12GB file
> (time dd if=/dev/zero of=test.data bs=1G count=12):
>
> writeback    3m10s [this series - v4]
> readahead    0m11s [this series - v4]
> mmap         0m11s [this series - v4]
> mmap         0m11s [master]
> loose        2m50s [this series - v4]
> loose        2m19s [master]
>
> That's a bit surprising. Why is loose and writeback slower?
>
> Next linear reading a 12GB file
> (time cat test.data > /dev/null):
>
> writeback    0m24s [this series - v4]
> readahead    0m25s [this series - v4]
> mmap         0m25s [this series - v4]
> mmap         0m9s  [master]
> loose        0m24s [this series - v4]
> loose        0m24s [master]
>
> mmap degredation sticks out here, and no improvement with the other modes?
>
> I always performed a guest reboot between each run BTW.
>
>
>
