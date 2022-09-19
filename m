Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2028F5BD163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiISPqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiISPqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:46:50 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70F11C3F;
        Mon, 19 Sep 2022 08:46:49 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51230)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaIyt-000hY1-Nw; Mon, 19 Sep 2022 09:46:47 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:34848 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaIys-007k7X-Mh; Mon, 19 Sep 2022 09:46:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220728091220.GA11207@redhat.com> <YuL9uc8WfiYlb2Hw@tycho.pizza>
        <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
        <YuPlqp0jSvVu4WBK@tycho.pizza>
        <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
        <YuQPc51yXhnBHjIx@tycho.pizza>
        <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
        <20220729204730.GA3625@redhat.com> <YuR4MRL8WxA88il+@ZenIV>
        <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
        <YvpRLJ79GRWYjLdf@tycho.pizza>
Date:   Mon, 19 Sep 2022 10:46:40 -0500
In-Reply-To: <YvpRLJ79GRWYjLdf@tycho.pizza> (Tycho Andersen's message of "Mon,
        15 Aug 2022 07:59:08 -0600")
Message-ID: <87wn9z1i5b.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oaIys-007k7X-Mh;;;mid=<87wn9z1i5b.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18PIokmn08vX/hBB3WTU24vRT4rnbzUX9U=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 503 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 11 (2.2%), parse: 1.22
        (0.2%), extract_message_metadata: 15 (2.9%), get_uri_detail_list: 1.06
        (0.2%), tests_pri_-1000: 19 (3.8%), tests_pri_-950: 1.54 (0.3%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 137 (27.3%), check_bayes:
        135 (26.9%), b_tokenize: 6 (1.1%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 118 (23.4%), b_finish: 1.10
        (0.2%), tests_pri_0: 298 (59.2%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 0.61 (0.1%), tests_pri_10:
        4.4 (0.9%), tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH v2] fuse: In fuse_flush only wait if someone wants
 the return code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tycho Andersen <tycho@tycho.pizza> writes:

> Hi,
>
> On Sat, Jul 30, 2022 at 12:10:33AM -0500, Eric W. Biederman wrote:
>> Al, vfs folks? (igrab/iput sorted so as not to be distractions).
>
> Any movement on this? Can you resend (or I can) the patch with the
> fixes for fuse at the very least?

Sorry for not replying earlier.  Thank you for taking this.

I had really meant to suggest something like that.  At the moment I have
a bit too much on my plate, so I am glad to see this moving forward.

I am a bit sad that I didn't succeed in starting a general vfs
discussion about this.  Oh well.  As long as we get weird bugs
like this fixed.

Eric

