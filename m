Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED53503816
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiDPT6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Apr 2022 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiDPT6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Apr 2022 15:58:41 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA19136E23
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Apr 2022 12:56:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id DBD09C00E8
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Apr 2022 21:56:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id yQIa8vJhEC_t for <linux-fsdevel@vger.kernel.org>;
        Sat, 16 Apr 2022 21:55:54 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id B7352C00A1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Apr 2022 21:55:54 +0200 (CEST)
Received: (qmail 4335 invoked from network); 17 Apr 2022 01:45:20 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 17 Apr 2022 01:45:20 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 86426460E36; Sat, 16 Apr 2022 21:55:54 +0200 (CEST)
Date:   Sat, 16 Apr 2022 21:55:54 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Max Kellermann <mk@cm4all.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <YlsfSqysfKJqwDVz@rabbit.intern.cm-ag>
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <c6b80014-846d-cd90-7e67-d72959ffabe1@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b80014-846d-cd90-7e67-d72959ffabe1@leemhuis.info>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/16 13:38, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> Thx for the report. Maybe a bisection is what's needed here, but lets
> see what David says, maybe he has a idea already.

I wish I could do that, but it's very hard to reproduce; the first
reports came after a week or so.  That way, a bisect would take
months.  So yes, wait for David, because he might give a clue how to
trigger the problem more quickly to make a bisect practical.
