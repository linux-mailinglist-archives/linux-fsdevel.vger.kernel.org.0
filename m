Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECF57D2B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiGURqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGURqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:46:09 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BED33A26;
        Thu, 21 Jul 2022 10:46:08 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44794)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oEaFT-00EnHe-8s; Thu, 21 Jul 2022 11:46:07 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37930 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oEaFS-00CknM-Ap; Thu, 21 Jul 2022 11:46:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-api@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
        <Ytl772fRS74eIneC@bombadil.infradead.org>
Date:   Thu, 21 Jul 2022 12:45:42 -0500
In-Reply-To: <Ytl772fRS74eIneC@bombadil.infradead.org> (Luis Chamberlain's
        message of "Thu, 21 Jul 2022 09:16:47 -0700")
Message-ID: <87wnc6nyux.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oEaFS-00CknM-Ap;;;mid=<87wnc6nyux.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19PVm7taLEyMu/qVXZ+V45ZQOvYPYkE79c=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 405 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.84 (0.2%),
         extract_message_metadata: 3.5 (0.9%), get_uri_detail_list: 1.46
        (0.4%), tests_pri_-1000: 3.5 (0.9%), tests_pri_-950: 1.17 (0.3%),
        tests_pri_-900: 0.91 (0.2%), tests_pri_-90: 89 (22.1%), check_bayes:
        88 (21.7%), b_tokenize: 6 (1.6%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 68 (16.7%), b_finish: 0.92
        (0.2%), tests_pri_0: 279 (69.0%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        1.96 (0.5%), tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] proc: fix create timestamp of files in proc
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Thu, Jul 21, 2022 at 04:16:17PM +0800, Zhang Yuchen wrote:
>> A user has reported a problem that the /proc/{pid} directory
>> creation timestamp is incorrect.
>
> The directory?

A bit of history that I don't think made it to the git log is that
procps uses the /proc/<pid> directory, to discover the uid and gid of the
process.

I have memories of Albert Cahalan reporting regressions because I
had tweaked the attributes of proc in ways that I expected no
one would care about and caused a regression in procps.

So it is not unreasonable for people to have used proc in surprising
ways.

I took a quick read through procps and it looks like procps reads
/proc/<pid>/stat to get the start_time of the process.


Which leads us to this quality of implementation issue that the time
on the inode of a proc directory is the first time that someone read
the directory and observed the file.  Which does not need to be anything
at all related to the start time.

I think except for the symlinks and files under /proc/pid/fd and
/proc/pid/fdinfo there is a very good case for making all of the files
/proc/pid have a creation time of equal to the creation of the process
in question.  Although the files under /proc/pid/task/ need to have
a time equal to the creation time of the thread in question.

Improving the quality of implementation requires caring enough to make
that change, and right now I don't.

At the same time I would say the suggested patch is a bad idea.
Any application that breaks because we hard set the timestamp on a proc
file or directory to the beginning of time is automatically counts as a
regression.

Since the entire point of the patch is to break applications that are
doing things wrong, aka cause regressions I don't think the patch
make sense.

So I would vote for understanding what the problem user is doing.  Then
either proc can be improved to better support users, or we can do
nothing.

Except for explaining the history and how people have legitimately used
implementation details of proc before, I am not really interested.  But
I do think we can do better.

Eric

