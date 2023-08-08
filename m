Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DAB774555
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjHHSl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjHHSlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:41:08 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF07B0D5A;
        Tue,  8 Aug 2023 10:48:56 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60450)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qTQp5-005HbQ-UB; Tue, 08 Aug 2023 11:48:48 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:53030 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qTQp4-007M6d-Rd; Tue, 08 Aug 2023 11:48:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Matthew Wilcox <willy@infradead.org>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
        <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
        <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
        <20230808-jacken-feigen-46727b8d37ad@brauner>
        <CAHk-=whiKJGTF2_oKOKMi9FzWSzcBkL_hYxOuvG-=Gc_C1JfFg@mail.gmail.com>
Date:   Tue, 08 Aug 2023 12:48:05 -0500
In-Reply-To: <CAHk-=whiKJGTF2_oKOKMi9FzWSzcBkL_hYxOuvG-=Gc_C1JfFg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 8 Aug 2023 10:22:18 -0700")
Message-ID: <87ttt9ctnu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qTQp4-007M6d-Rd;;;mid=<87ttt9ctnu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/Qb/aRBSYlgQSNZ4G5ISBQguxHy+ocYwk=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 479 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.76 (0.2%),
         extract_message_metadata: 11 (2.3%), get_uri_detail_list: 0.82 (0.2%),
         tests_pri_-2000: 11 (2.4%), tests_pri_-1000: 2.4 (0.5%),
        tests_pri_-950: 1.25 (0.3%), tests_pri_-900: 1.00 (0.2%),
        tests_pri_-200: 0.83 (0.2%), tests_pri_-100: 3.8 (0.8%),
        tests_pri_-90: 63 (13.1%), check_bayes: 61 (12.7%), b_tokenize: 8
        (1.7%), b_tok_get_all: 6 (1.3%), b_comp_prob: 2.8 (0.6%),
        b_tok_touch_all: 40 (8.3%), b_finish: 0.93 (0.2%), tests_pri_0: 179
        (37.4%), check_dkim_signature: 0.67 (0.1%), check_dkim_adsp: 4.5
        (0.9%), poll_dns_idle: 182 (37.9%), tests_pri_10: 2.3 (0.5%),
        tests_pri_500: 189 (39.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 8 Aug 2023 at 10:15, Christian Brauner <brauner@kernel.org> wrote:
>>
>> I think you're at least missing the removal of the PF_KTHREAD check
>
> Yup.
>
>>                 It'd be neat to leave that in so
>> __fput_sync() doesn't get proliferated to non PF_KTHREAD without us
>> noticing. So maybe we just need a tiny primitive.
>
> Considering that over the decade we've had this, we've only grown two
> cases of actually using it, I think we're fine.

That and two cases of flush_delayed_fput() followed by task_work_run().

That combined with a maintainer who was actively against any new
calls to __fput_sync and a version of __fput_sync that called BUG_ON
if you used it.

So I am not 100% convinced that there were so few calls to __fput_sync
simply because people couldn't think of a need for it.

Eric


