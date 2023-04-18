Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134DA6E5F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDRKvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 06:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDRKvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:51:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88850E49;
        Tue, 18 Apr 2023 03:51:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB347168F;
        Tue, 18 Apr 2023 03:52:01 -0700 (PDT)
Received: from [10.1.36.30] (FVFG51LCQ05N.cambridge.arm.com [10.1.36.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 737073F5A1;
        Tue, 18 Apr 2023 03:51:16 -0700 (PDT)
Message-ID: <1cfcab69-cc4d-2038-2ac1-be241a547639@arm.com>
Date:   Tue, 18 Apr 2023 11:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] fcntl: Cast commands with int args explicitly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-morello@op-lists.linaro.org
References: <20230414152459.816046-1-Luca.Vizzarro@arm.com>
 <20230414152459.816046-2-Luca.Vizzarro@arm.com>
 <20230414154631.GK3390869@ZenIV>
From:   Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20230414154631.GK3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/04/2023 16:46, Al Viro wrote

> Why?
> ...
> Why???
 > ...
> These two are clearly bogus and I'd like to see more details
> on the series rationale, please.

Mark preceded me with his reply, which is perfectly summarising
the whole point of this series. – Thank you Mark!

As for FD_SETFD, yes it's not necessary. The only reason I
changed the variable was to denote the argument as being
classified as an `int` as per the man page. If I were not to
change it, it would have been the only command with an `int`
argument not to use `argi`. Therefore it's also for
consistency's sake.

Hope this helps.

Best,
Luca
