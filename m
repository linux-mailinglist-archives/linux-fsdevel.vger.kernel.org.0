Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CBF131783
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 19:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgAFSbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 13:31:13 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:37419 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFSbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:31:13 -0500
Received: by mail-il1-f182.google.com with SMTP id t8so43389408iln.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 10:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpYkP5LNEU0kgNBHOElXzLTySBihXK+6oFjoFYy2Rfs=;
        b=e9Q+CPQqDiqKy/9otdoD3423BzWDI6HN4CPuBosPI51OP0E7Ib2RZedwUdVAoMQ5Pi
         FQx+7ftx2uTGEep9Q5zgR2u0IWDusq6s4u+c1fMyuIFGmXKQQUDLjMMNT3CI17jfnjy3
         WzK4nLCrqXe7sNRlmcLH1djJ6OwkCFN07WoZv3cFNIb9vZw6B9smioFBcWBEOjLvU1JN
         X6hWQWmhQiHLNQTGGhhnNE5ZI3/E2VVm2h9Bt+rAoyhSWgvH3A0cUkj68N5p3sm4jRj5
         ck4loCpYfVJEjYBHcpKS/R61sxCPHMIX+SH0dkYktSDvil3mL8n6vcLFH+P98OUeRrcx
         CeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpYkP5LNEU0kgNBHOElXzLTySBihXK+6oFjoFYy2Rfs=;
        b=YqjESUUiTeJuP75vA/tSnW79yBqnf9ZsZhzQx6wN3oghk0txP9ToDWL9A7welFIGeL
         Z5SWUCHlCxgzk1SgSNZ5jj6PzFqlqTik4Xf9/8iw3ZMFzHyWmCEmhAKRvKAZl4+/oqgK
         A+EK/jM1b4wD+e8k8ingVxCaHuKT5AAg9u6fUcidXZg76SXjXWvcvW+C4ClW0WyJ5RAO
         sdiPyvEfS0m5Am8qKJoqEpccOkQIhbN0Pl7o9DkbQZ7oR0ks+ctdtIbW31zXnzEx4J8U
         alIiRgb8QtdgiRXZGqdyG0Oq3pDxSf/JPAPBuUdyhnCdltWbfOqZnHy5kaIfyz414DYz
         f3gQ==
X-Gm-Message-State: APjAAAVwboeWA/+D4NyPlzTJ0oPBxHlvH3hN5JsciYI1EIbpRNiwiIr6
        LjRYvIgHkSCNYHrR2Bg4UDnZ/2PQyb88Q/Z8WO4=
X-Google-Smtp-Source: APXvYqzEG1gVWIhtVDgS5cb7urIUnaKnxudyr3knireJkAWHnE40clrSTRVD+I73jDK+3SMRQQCI4YQnjiLNX0phV8g=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr91950168ilg.137.1578335472529;
 Mon, 06 Jan 2020 10:31:12 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhJhzUj_sjhDknGzdLs6kOXzt3GO2vyCzmuBNTSsAQLGA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jan 2020 20:31:00 +0200
Message-ID: <CAOQ4uxjAzAL_pNr-hU7gYcv0ARmRXK3SHYUL7ySKsNBDz1WpmQ@mail.gmail.com>
Subject: Re: Questions about filesystems from SQLite author presentation
To:     Sitsofe Wheeler <sitsofe@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, drh@sqlite.org,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 6, 2020 at 5:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jan 6, 2020 at 9:26 AM Sitsofe Wheeler <sitsofe@gmail.com> wrote:
> >
> > At Linux Plumbers 2019 Dr Richard Hipp presented a talk about SQLite
> > (https://youtu.be/-oP2BOsMpdo?t=5525 ). One of the slides was titled
> > "Things to discuss"
> > (https://sqlite.org/lpc2019/doc/trunk/slides/sqlite-intro.html/#6 )
> > and had a few questions:
> >
> [...]
> >
> > However, there were even more questions in the briefing paper
> > (https://sqlite.org/lpc2019/doc/trunk/briefing.md and search for '?')
> > that couldn't be asked due to limited time. Does anyone know the
> > answer to the extended questions and whether the the above is right
> > deduction for the questions that were asked?
> >
>
> As Jan said, there is a difference between the answer to "what is the
> current behavior" and "what are filesystem developers willing to commit
> as behavior that will remain the same in the future", but I will try to provide
> some answers to your questions.
>
> > If a power loss occurs at about the same time that a file is being extended
> > with new data, will the file be guaranteed to contain valid data after reboot,
> > or might the extended area of the file contain all zeros or all ones or
> > arbitrary content? In other words, is the file data always committed to disk
> > ahead of the file size?
>
> While that statement would generally be true (ever since ext3
> journal=ordered...),

Bah! scratch that. The statement is generally not true.
Due to delayed allocation with xfs/ext4 you are much more likely to
find the extended areas contain all zeroes.
The only guaranty AFAIK is that with truncate+extend sequence, you
won't find the old data in the re-extended area.

Thanks,
Amir.
