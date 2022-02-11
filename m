Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24CC4B2F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 22:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbiBKVWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 16:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbiBKVWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:22:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B718C58;
        Fri, 11 Feb 2022 13:22:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1EFAB82CA9;
        Fri, 11 Feb 2022 21:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DA5C340ED;
        Fri, 11 Feb 2022 21:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644614532;
        bh=gyVu93BQk4R2bmHla8KOVBKXWrvAaooun3JJFqGmpzg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oKrVRQrCa8XMlWmHFm6PkAHVuQmePT6UgVX22/hhiWaX7L3p4XlBjXZ7MvhK3DMWL
         GT7fCDGq3AQK/o1WHhgXb7TFa2FbjHmFyoJ3r7Wss9b5hvHlE7G9x8rOI52TdV24xV
         4M9oiQFe/w7YjTJ7+5QMNrjD5ACjbzaXqRMSPcOr1XomSCMyWCSNaYy0i7IeNAv6SY
         EqQNdeZfggM/qwbj0XYar7XRGBlD8i9ziuRYKJSE8w3rnDPNMM8p3M7XhrHO2J87RF
         nMVY3yWjPoPYjln63FVuo5VVQnQLclCzKc4rHNyn6rJoHGTXQMBws+Gpjxa8COc8YN
         +QJmgBq9rfFzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E69DE5C0A07; Fri, 11 Feb 2022 13:22:11 -0800 (PST)
Date:   Fri, 11 Feb 2022 13:22:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] Splat in __register_sysctl_table() in next-20220210
Message-ID: <20220211212211.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220211170455.GA1328576@paulmck-ThinkPad-P17-Gen-1>
 <YgakyWEJvsUvaAtW@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgakyWEJvsUvaAtW@bombadil.infradead.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:02:49AM -0800, Luis Chamberlain wrote:
> On Fri, Feb 11, 2022 at 09:04:55AM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > I just wanted to be the 20th person to report the below splat in
> > init_fs_stat_sysctls() during boot.  ;-)
> > 
> > It happens on all rcutorture scenarios, for whatever that might be
> > worth.
> 
> It should be fixed on today's linux-next, see this discussion:
> 
> https://lore.kernel.org/linux-ext4/20220210091648.w5wie3llqri5kfw3@quack3.lan/T/#mfc3683a68aaec8595cd5f26e138453132a3e1d43
> 
> Essentially there was a fix which Andrew merged. The Linus merged it.
> But linux-next carried Andrew's fix too, so there was a double
> registration.
> 
> Please let me know if you still see the issue on next-20220211 !

And next-20220211 worked just fine, thank you!

							Thanx, Paul
