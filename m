Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D04D640D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347397AbiCKOqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 09:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbiCKOqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423E1AC282;
        Fri, 11 Mar 2022 06:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2D760B3F;
        Fri, 11 Mar 2022 14:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734F8C340ED;
        Fri, 11 Mar 2022 14:45:26 +0000 (UTC)
Date:   Fri, 11 Mar 2022 09:45:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/10] ext4: Improve FC trace events
Message-ID: <20220311094524.1fa2d98f@gandalf.local.home>
In-Reply-To: <20220311051249.ltgqbjjothbrkbno@riteshh-domain>
References: <cover.1646922487.git.riteshh@linux.ibm.com>
        <20220310110553.431cc997@gandalf.local.home>
        <20220310170731.hq6z6flycmgkhnaa@riteshh-domain>
        <20220310193936.38ae7754@gandalf.local.home>
        <20220311021931.d4oozgtefbalrcch@riteshh-domain>
        <20220310213356.3948cfb7@gandalf.local.home>
        <20220311031431.3sfbibwuthn4xkym@riteshh-domain>
        <20220310233234.4418186a@gandalf.local.home>
        <20220311051249.ltgqbjjothbrkbno@riteshh-domain>
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

On Fri, 11 Mar 2022 10:42:49 +0530
Ritesh Harjani <riteshh@linux.ibm.com> wrote:

> You may add below, if you like:-
> 
> Reported-and-tested-by: Ritesh Harjani <riteshh@linux.ibm.com>

Will do. Thanks for testing.

I'll be adding this for the next merge window. I don't think this is
something that needs to be added to this rc release nor stable. Do you
agree?

-- Steve
