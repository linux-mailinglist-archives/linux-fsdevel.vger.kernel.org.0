Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E359343B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiHORzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHORze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:55:34 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6BFE020;
        Mon, 15 Aug 2022 10:55:32 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9529777A; Mon, 15 Aug 2022 12:55:30 -0500 (CDT)
Date:   Mon, 15 Aug 2022 12:55:30 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v2] fuse: In fuse_flush only wait if someone wants
 the return code
Message-ID: <20220815175530.GA23095@mail.hallyn.com>
References: <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
 <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
 <YuQPc51yXhnBHjIx@tycho.pizza>
 <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
 <20220729204730.GA3625@redhat.com>
 <YuR4MRL8WxA88il+@ZenIV>
 <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
 <YvpRLJ79GRWYjLdf@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvpRLJ79GRWYjLdf@tycho.pizza>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:59:08AM -0600, Tycho Andersen wrote:
> Hi,
> 
> On Sat, Jul 30, 2022 at 12:10:33AM -0500, Eric W. Biederman wrote:
> > Al, vfs folks? (igrab/iput sorted so as not to be distractions).
> 
> Any movement on this? Can you resend (or I can) the patch with the
> fixes for fuse at the very least?
> 
> Thanks,

If you resend with the fixes, I'd like to do a bit of testing with it.
