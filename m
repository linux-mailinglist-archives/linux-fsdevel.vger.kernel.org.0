Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339E4797A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbjIGRio convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 7 Sep 2023 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbjIGRil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:38:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9442990
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 10:38:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2CFC116B8;
        Thu,  7 Sep 2023 11:17:47 +0000 (UTC)
Date:   Thu, 7 Sep 2023 07:18:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230907071801.1d37a3c5@gandalf.local.home>
In-Reply-To: <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
        <ZPkDLp0jyteubQhh@dread.disaster.area>
        <20230906215327.18a45c89@gandalf.local.home>
        <ZPkz86RRLaYOkmx+@dread.disaster.area>
        <20230906225139.6ffe953c@gandalf.local.home>
        <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Sep 2023 13:38:40 +1000
Dave Chinner <david@fromorbit.com> wrote:

> Hence, IMO, gutting a filesystem implementation to just support
> read-only behaviour "to prolong it's support life" actually makes
> things worse from a maintenance and testing persepective, not
> better....

From your other email about 10 years support, you could first set a fs to
read-only, and then after so long (I'm not sure 10 years is really
necessary), then remove it.

That is, make it the stage before removal. If no one complains about it
being read-only after several years, then it's highly likely that no one is
using it. If someone does complain, you can tell them to either maintain
it, or start moving all their data to another fs.

For testing, you could even have an #ifdef that needs to be manually
changed (not a config option) to make it writable.

-- Steve
