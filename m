Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776004DCDC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiCQSkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 14:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiCQSkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:40:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F48204C85;
        Thu, 17 Mar 2022 11:38:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB84B81E97;
        Thu, 17 Mar 2022 18:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BFCC340EC;
        Thu, 17 Mar 2022 18:38:48 +0000 (UTC)
Date:   Thu, 17 Mar 2022 14:38:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org, hca@linux.ibm.com
Subject: Re: [PATCHv3 02/10] ext4: Fix ext4_fc_stats trace point
Message-ID: <20220317143846.7148d0cb@gandalf.local.home>
In-Reply-To: <yt9d1qz05zk1.fsf@linux.ibm.com>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
        <b4b9691414c35c62e570b723e661c80674169f9a.1647057583.git.riteshh@linux.ibm.com>
        <yt9dr1706b4i.fsf@linux.ibm.com>
        <20220317145008.73nm7hqtccyjy353@riteshh-domain>
        <yt9d1qz05zk1.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Mar 2022 17:11:42 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:


> Looking at the oops output again made me realizes that the snprintf
> tries to write into pages that are mapped RO. Talking to Heiko he
> mentioned that s390 maps rodata/text RO when setting up the initial
> mapping while x86 has a RW mapping in the beginning and changes that
> later to RO. I haven't verified that, but that might be a reason why it
> works on x86.
> 

Yes, I discovered this too. I'm currently looking to see how to fix it.

-- Steve
