Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98711D164D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbgEMNqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 09:46:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49832 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387751AbgEMNqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 09:46:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYri1-0007Yh-74; Wed, 13 May 2020 07:46:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYri0-0006Pz-3e; Wed, 13 May 2020 07:46:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
        <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
        <20200512003305.GX11244@42.do-not-panic.com>
        <87y2pxs73w.fsf@x220.int.ebiederm.org>
        <20200512172413.GC11244@42.do-not-panic.com>
        <87k11hrqzc.fsf@x220.int.ebiederm.org>
        <20200512220341.GE11244@42.do-not-panic.com>
Date:   Wed, 13 May 2020 08:42:30 -0500
In-Reply-To: <20200512220341.GE11244@42.do-not-panic.com> (Luis Chamberlain's
        message of "Tue, 12 May 2020 22:03:41 +0000")
Message-ID: <87d078oss9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYri0-0006Pz-3e;;;mid=<87d078oss9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vmS02bGQubPKIl5qUYavG96RWvX+2dVI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 682 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 1.26 (0.2%),
         extract_message_metadata: 4.5 (0.7%), get_uri_detail_list: 1.90
        (0.3%), tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.72 (0.3%),
        tests_pri_-900: 1.38 (0.2%), tests_pri_-90: 328 (48.1%), check_bayes:
        326 (47.8%), b_tokenize: 11 (1.7%), b_tok_get_all: 8 (1.1%),
        b_comp_prob: 3.5 (0.5%), b_tok_touch_all: 300 (43.9%), b_finish: 1.03
        (0.2%), tests_pri_0: 298 (43.7%), check_dkim_signature: 0.90 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.60 (0.1%), tests_pri_10:
        3.2 (0.5%), tests_pri_500: 16 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>> 
>> > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
>> >> Luis Chamberlain <mcgrof@kernel.org> writes:
>> >> 
>> >> > +static struct ctl_table fs_base_table[] = {
>> >> > +	{
>> >> > +		.procname	= "fs",
>> >> > +		.mode		= 0555,
>> >> > +		.child		= fs_table,
>> >> > +	},
>> >> > +	{ }
>> >> > +};
>> >>   ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
>> >> > > +static int __init fs_procsys_init(void)
>> >> > +{
>> >> > +	struct ctl_table_header *hdr;
>> >> > +
>> >> > +	hdr = register_sysctl_table(fs_base_table);
>> >>               ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
>> >> 	AKA
>> >>         hdr = register_sysctl("fs", fs_table);
>> >
>> > Ah, much cleaner thanks!
>> 
>> It is my hope you we can get rid of register_sysctl_table one of these
>> days.  It was the original interface but today it is just a
>> compatibility wrapper.
>> 
>> I unfortunately ran out of steam last time before I finished converting
>> everything over.
>
> Let's give it one more go. I'll start with the fs stuff.

Just to be clear moving the tables out of kernel/sysctl.c is a related
but slightly different problem.

Today it looks like there are 35 calls of register_sysctl_table
and 9 calls of register_sysctl_paths.

Among them is lib/sysctl_test.c and check-sysctl-docs.

Meanwhile I can only find 5 calls to register_sysctl in the tree
so it looks like I didn't get very far converting things over.

Eric

