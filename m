Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4478F248555
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHRMwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 08:52:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60680 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHRMwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:52:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k815n-002tHu-Ks; Tue, 18 Aug 2020 06:51:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k815m-0002uy-Vs; Tue, 18 Aug 2020 06:51:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        "Daniel P. Berrang\?\?" <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
        <20200817220425.9389-17-ebiederm@xmission.com>
        <20200818112020.GA17080@infradead.org>
Date:   Tue, 18 Aug 2020 07:48:21 -0500
In-Reply-To: <20200818112020.GA17080@infradead.org> (Christoph Hellwig's
        message of "Tue, 18 Aug 2020 12:20:20 +0100")
Message-ID: <87blj83ysq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k815m-0002uy-Vs;;;mid=<87blj83ysq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19i1uubQLTFHwGCBALZbWaXu5opyhIYahI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4768]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 279 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (3.7%), b_tie_ro: 9 (3.2%), parse: 0.83 (0.3%),
         extract_message_metadata: 10 (3.7%), get_uri_detail_list: 0.48 (0.2%),
         tests_pri_-1000: 17 (6.0%), tests_pri_-950: 1.31 (0.5%),
        tests_pri_-900: 1.07 (0.4%), tests_pri_-90: 72 (25.7%), check_bayes:
        70 (25.1%), b_tokenize: 7 (2.5%), b_tok_get_all: 6 (2.2%),
        b_comp_prob: 1.78 (0.6%), b_tok_touch_all: 52 (18.6%), b_finish: 0.91
        (0.3%), tests_pri_0: 155 (55.4%), check_dkim_signature: 0.50 (0.2%),
        check_dkim_adsp: 2.4 (0.9%), poll_dns_idle: 0.75 (0.3%), tests_pri_10:
        2.1 (0.8%), tests_pri_500: 7 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 17/17] file: Rename __close_fd to close_fd and remove the files parameter
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> Please kill off ksys_close as well while you're at it.

Good point.  ksys_close is just a trivial wrapper around close_fd.  So
the one caller of ksys_close autofs_dev_ioctl_closemount can be
trivially changed to call close_fd.

Eric
