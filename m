Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C574E1B96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 13:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbiCTM3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245019AbiCTM3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:29:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6C120F7E;
        Sun, 20 Mar 2022 05:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8814CB80E5C;
        Sun, 20 Mar 2022 12:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC28C340E9;
        Sun, 20 Mar 2022 12:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647779285;
        bh=0AMjHqXYqQt/Dw4rOqZiu812pqzr9WBYwEqgRxhLCCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SLlRB1Oq2fIcwWMQBF6P6sYZph2IYUCT70/hn6bS2wXmRTI1Eq+SLAurUTmVjp6NN
         xFFwInFMKWt+OKvkiAgu7IGsGz0PF1w/sLiBK+cDt7f8t13M/PKmafa/W4/Y3oUfSr
         Szah1kVgRtInDLytD9v/4f8JqAM+auUezghUYFG6PDQTKcXDFT64v9A5szDju/1TuE
         zTTcK0xAgR/Qy7B+ASJniN09YgkTN/1bnE/eH22AhcN7nrF2/ea6q7RmH3Wyztw6zW
         RG63Fs1oyfN7VeEipYb0l0NHed4aPd5QlIjcOsmUdVVQwnbEi0t+qVzukYacoDQENh
         1ualVRpwlvAqA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nVufC-00FlS9-JZ; Sun, 20 Mar 2022 12:28:02 +0000
Date:   Sun, 20 Mar 2022 12:28:01 +0000
Message-ID: <87lex4yfji.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH] tracing: Have type enum modifications copy the strings
In-Reply-To: <20220318153432.3984b871@gandalf.local.home>
References: <20220318153432.3984b871@gandalf.local.home>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rostedt@goodmis.org, linux-kernel@vger.kernel.org, mingo@kernel.org, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, svens@linux.ibm.com, riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu, harshadshirwadkar@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Mar 2022 19:34:32 +0000,
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When an enum is used in the visible parts of a trace event that is
> exported to user space, the user space applications like perf and
> trace-cmd do not have a way to know what the value of the enum is. To
> solve this, at boot up (or module load) the printk formats are modified to
> replace the enum with their numeric value in the string output.
> 
> Array fields of the event are defined by [<nr-elements>] in the type
> portion of the format file so that the user space parsers can correctly
> parse the array into the appropriate size chunks. But in some trace
> events, an enum is used in defining the size of the array, which once
> again breaks the parsing of user space tooling.
> 
> This was solved the same way as the print formats were, but it modified
> the type strings of the trace event. This caused crashes in some
> architectures because, as supposed to the print string, is a const string
> value. This was not detected on x86, as it appears that const strings are
> still writable (at least in boot up), but other architectures this is not
> the case, and writing to a const string will cause a kernel fault.
> 
> To fix this, use kstrdup() to copy the type before modifying it. If the
> trace event is for the core kernel there's no need to free it because the
> string will be in use for the life of the machine being on line. For
> modules, create a link list to store all the strings being allocated for
> modules and when the module is removed, free them.
> 
> Link: https://lore.kernel.org/all/yt9dr1706b4i.fsf@linux.ibm.com/
> 
> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This fixes booting on arm64 with ext4 as a module, so FWIW:

Tested-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
