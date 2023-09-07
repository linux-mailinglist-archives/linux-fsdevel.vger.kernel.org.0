Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A6797A65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbjIGRjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbjIGRjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:39:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A850E45
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 10:38:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96C8C116C8;
        Thu,  7 Sep 2023 11:22:31 +0000 (UTC)
Date:   Thu, 7 Sep 2023 07:22:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230907072245.666b2fda@gandalf.local.home>
In-Reply-To: <20230907110409.GH19790@gate.crashing.org>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
        <ZPkDLp0jyteubQhh@dread.disaster.area>
        <20230906215327.18a45c89@gandalf.local.home>
        <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain>
        <20230907110409.GH19790@gate.crashing.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Sep 2023 06:04:09 -0500
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Thu, Sep 07, 2023 at 12:48:25PM +0300, Dan Carpenter via Gcc-patches wrote:
> > I started to hunt
> > down all the Makefile which add a -Werror but there are a lot and
> > eventually I got bored and gave up.  
> 
> I have a patch stack for that, since 2014 or so.  I build Linux with
> unreleased GCC versions all the time, so pretty much any new warning is
> fatal if you unwisely use -Werror.
> 
> > Someone should patch GCC so there it checks an environment variable to
> > ignore -Werror.  Somethine like this?  
> 
> No.  You should patch your program, instead.  One easy way is to add a
> -Wno-error at the end of your command lines.  Or even just -w if you
> want or need a bigger hammer.

That's not really possible when bisecting a kernel bug into older kernels.
The build system is highly complex and requires hundreds of changes to do
what you suggested. As it is for a bisection that takes a minimum of 13
iterations, your approach just isn't feasible.

-- Steve
