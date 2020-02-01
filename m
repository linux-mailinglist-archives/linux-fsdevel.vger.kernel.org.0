Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59F314F971
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 19:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgBAScc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 13:32:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBAScc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:32:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixxZH-005pJF-4j; Sat, 01 Feb 2020 18:32:31 +0000
Date:   Sat, 1 Feb 2020 18:32:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix do_last() regression
Message-ID: <20200201183231.GL23230@ZenIV.linux.org.uk>
References: <20200201162645.GJ23230@ZenIV.linux.org.uk>
 <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKnDkhvV44mYnJfmSeEnhF-ETBHGtq--8h3c03XoXP7w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 01, 2020 at 10:29:17AM -0800, Linus Torvalds wrote:
> On Sat, Feb 1, 2020 at 8:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Brown paperbag time: fetching ->i_uid/->i_mode really should've been
> > done from nd->inode.
> 
> I'm assuming you want me to apply this directly as a patch, or was it
> meant as a heads-up with a future pull request?

The former, actually, but I can throw it into #fixes and send a pull
request if you prefer it that...
