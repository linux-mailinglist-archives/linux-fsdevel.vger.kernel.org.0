Return-Path: <linux-fsdevel+bounces-2803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3EA7EA2D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 19:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8071AB20A0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67523740;
	Mon, 13 Nov 2023 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19323746
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 18:30:07 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E910F4;
	Mon, 13 Nov 2023 10:30:06 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33492)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r2bhB-00CASw-Tk; Mon, 13 Nov 2023 11:30:01 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:44754 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1r2bh9-009HVJ-4d; Mon, 13 Nov 2023 11:30:01 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,  David Hildenbrand
 <david@redhat.com>,  sonicadvance1@gmail.com,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-mm@kvack.org,  kernel-dev@igalia.com,  kernel@gpiccoli.net,
  oleg@redhat.com,  yzaikin@google.com,  mcgrof@kernel.org,
  akpm@linux-foundation.org,  brauner@kernel.org,  viro@zeniv.linux.org.uk,
  willy@infradead.org,  dave@stgolabs.net,  joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
	<e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
	<202310091034.4F58841@keescook>
	<8dc5069f-5642-cc5b-60e0-0ed3789c780b@igalia.com>
Date: Mon, 13 Nov 2023 12:29:30 -0600
In-Reply-To: <8dc5069f-5642-cc5b-60e0-0ed3789c780b@igalia.com> (Guilherme
	G. Piccoli's message of "Mon, 13 Nov 2023 14:33:13 -0300")
Message-ID: <871qctwlpx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r2bh9-009HVJ-4d;;;mid=<871qctwlpx.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/I/1FYBxErHqdGaUWSfI4eU8q0l1NRhPI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Guilherme G. Piccoli" <gpiccoli@igalia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2049 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.3 (0.2%), b_tie_ro: 2.2 (0.1%), parse: 0.82
	(0.0%), extract_message_metadata: 13 (0.7%), get_uri_detail_list: 1.87
	(0.1%), tests_pri_-2000: 6 (0.3%), tests_pri_-1000: 3.6 (0.2%),
	tests_pri_-950: 1.52 (0.1%), tests_pri_-900: 1.27 (0.1%),
	tests_pri_-90: 100 (4.9%), check_bayes: 98 (4.8%), b_tokenize: 9
	(0.5%), b_tok_get_all: 7 (0.3%), b_comp_prob: 1.97 (0.1%),
	b_tok_touch_all: 77 (3.7%), b_finish: 0.69 (0.0%), tests_pri_0: 279
	(13.6%), check_dkim_signature: 0.40 (0.0%), check_dkim_adsp: 2.6
	(0.1%), poll_dns_idle: 1623 (79.2%), tests_pri_10: 1.69 (0.1%),
	tests_pri_500: 1636 (79.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> On 09/10/2023 14:37, Kees Cook wrote:
>> On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
>>> On 07.09.23 22:24, Guilherme G. Piccoli wrote:
>>>> Currently the kernel provides a symlink to the executable binary, in the
>>>> form of procfs file exe_file (/proc/self/exe_file for example). But what
>>>> happens in interpreted scenarios (like binfmt_misc) is that such link
>>>> always points to the *interpreter*. For cases of Linux binary emulators,
>>>> like FEX [0] for example, it's then necessary to somehow mask that and
>>>> emulate the true binary path.
>>>
>>> I'm absolutely no expert on that, but I'm wondering if, instead of modifying
>>> exe_file and adding an interpreter file, you'd want to leave exe_file alone
>>> and instead provide an easier way to obtain the interpreted file.
>>>
>>> Can you maybe describe why modifying exe_file is desired (about which
>>> consumers are we worrying? ) and what exactly FEX does to handle that (how
>>> does it mask that?).
>>>
>>> So a bit more background on the challenges without this change would be
>>> appreciated.
>> 
>> Yeah, it sounds like you're dealing with a process that examines
>> /proc/self/exe_file for itself only to find the binfmt_misc interpreter
>> when it was run via binfmt_misc?
>> 
>> What actually breaks? Or rather, why does the process to examine
>> exe_file? I'm just trying to see if there are other solutions here that
>> would avoid creating an ambiguous interface...
>> 
>
> Thanks Kees and David! Did Ryan's thorough comment addressed your
> questions? Do you have any take on the TODOs?
>
> I can maybe rebase against 6.7-rc1 and resubmit , if that makes sense!
> But would be better having the TODOs addressed, I guess.

Currently there is a mechanism in the kernel for changing
/proc/self/exe.  Would that be reasonable to use in this case?

It came from the checkpoint/restart work, but given that it is already
implemented it seems like the path of least resistance to get your
binfmt_misc that wants to look like binfmt_elf to use that mechanism.

Eric

