Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4107A4C8E8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiCAPHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 10:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiCAPHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:07:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28543A650E;
        Tue,  1 Mar 2022 07:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D20F9B81986;
        Tue,  1 Mar 2022 15:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC2C340EE;
        Tue,  1 Mar 2022 15:06:52 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:06:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?UTF-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
Message-ID: <20220301100650.52db90d8@gandalf.local.home>
In-Reply-To: <CAGS_qxprS1e_f_K6bi-RvVESoPJ2yQgQVszcmcRFq_VQWduyAA@mail.gmail.com>
References: <20220224054332.1852813-1-keescook@chromium.org>
        <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
        <202202232208.B416701@keescook>
        <20220224091550.2b7e8784@gandalf.local.home>
        <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
        <20220228232131.4b9cee32@rorschach.local.home>
        <CAGS_qxprS1e_f_K6bi-RvVESoPJ2yQgQVszcmcRFq_VQWduyAA@mail.gmail.com>
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

On Mon, 28 Feb 2022 22:42:51 -0800
Daniel Latypov <dlatypov@google.com> wrote:

> But it'd definitely be interesting to try and get klp_arch_set_pc()
> working on UML if that's a possibility!
> Speaking from ignorance, I can see this either being somewhat simple

Looking at UML, it doesn't even look like it has ftrace support. So that
would be required to do it for that arch.

For UML, I'm not sure its worth it. I don't use UML but maybe others would
want ftrace for it? As UML runs in userspace, the motivation for things like
ftrace is not as high as you have gdb to walk through everything.

That said, I'm sure it would be a fun exercise for anyone to port ftrace to
UML :-)

-- Steve
