Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A08F4CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfHOTix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:38:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33154 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbfHOTix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:38:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so3259974ljz.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMwOuV3nMz/hoRB1Cse/AbiFhP4WrksE1suSS0/V1zE=;
        b=YmGIhLIQHRX1aKG0aqinsyf8Q6Cz8DldpQwWcGk+3w0bstMiMpVU5jvU0qMkhk9iqJ
         i+43l3YXMdK3T4S3opKhlYw/6UZSza9gRXU3Bz9lQXs+DX3uDP32Tlqgca7j09ZmGM/+
         DdfOz+AukMq5QpjiXFdsZmJDBjz4N4+21ioXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMwOuV3nMz/hoRB1Cse/AbiFhP4WrksE1suSS0/V1zE=;
        b=UhWcv2HLqlzpuyoxOE72qS7cgIQtCV6edS7Ry9H0V6Zl1EuFovstY1VTqS0pdpFof4
         qUM1+5XoZ+xMlzFPTjINjI2jjWLGOb07aHfjxU0Vq8oxvl1k8nmOxUS1wkot5PKyHJtR
         Hoz7HEEakwOsvoMSoBuUHYd7imSlZLsYkYVeHAJfst2LI4y92KEGn6hSiF6LSJ8g/pxV
         fmrcQ33rpGA3PUYNmAxgjuC1z2ybqrF6cgiONUjxD+vHc581j1gSYaYTE/PFUKZbyVce
         /4EHCHlg64JiCQHLrE/Qa3QOZcHRxExDgCp8nmjonzL9ELZGfmN9OjT73as2D3zwNU/C
         fCuQ==
X-Gm-Message-State: APjAAAVJCMQ2l5jjX4EOi5LyYZxz0vqeVnxeosdTGkO+yOwnXI1QEw8G
        xLZgBSUJP9VobwDZxtIiRufVtvjfdYA=
X-Google-Smtp-Source: APXvYqzfFkGc0bTyGy01tmd35qNkcHPsFLTRBPM1NHvjY+ECchiJzk330RAYuENnMfhaMtaeYBoVkQ==
X-Received: by 2002:a2e:b1c4:: with SMTP id e4mr2971806lja.101.1565897930835;
        Thu, 15 Aug 2019 12:38:50 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s11sm616777ljj.37.2019.08.15.12.38.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:38:49 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v16so474244lfg.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 12:38:49 -0700 (PDT)
X-Received: by 2002:a19:c20b:: with SMTP id l11mr3214120lfc.106.1565897929268;
 Thu, 15 Aug 2019 12:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190815171347.GD15186@magnolia>
In-Reply-To: <20190815171347.GD15186@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 12:38:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHuHLK49LKQhtERXaq0OYUnug4DJZFLPq9RHEG2Cm+bQ@mail.gmail.com>
Message-ID: <CAHk-=wiHuHLK49LKQhtERXaq0OYUnug4DJZFLPq9RHEG2Cm+bQ@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: fixes for 5.3-rc5
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pulled. Just a quick note:

On Thu, Aug 15, 2019 at 10:13 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> - Convert more directory corruption debugging asserts to actual
>   EFSCORRUPTED returns instead of blowing up later on.

The proper error code looks like an obvious improvement, but I do
wonder if there should be some (ratelimited) system logging too?

I've seen a lot of programs that don't report errors very clearly and
might just silently stop running and as a sysadmin I'd think I'd
rather have something in the system logs than users saying "my app
crashes at startup"/

Maybe the logging ends up being there already - just done later. It
wasn't obvious from the patch, and I didn't check the whole callchain
(only direct callers).

                  Linus
