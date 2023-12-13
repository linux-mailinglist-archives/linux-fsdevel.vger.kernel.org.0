Return-Path: <linux-fsdevel+bounces-5992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACF811C29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED571C21233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799859551;
	Wed, 13 Dec 2023 18:18:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C435AF;
	Wed, 13 Dec 2023 10:18:12 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:55092)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rDToA-000YZK-3k; Wed, 13 Dec 2023 11:18:10 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:53124 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rDTo9-007oxM-1R; Wed, 13 Dec 2023 11:18:09 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,  Joel Granados
 <j.granados@samsung.com>,  Kees Cook <keescook@chromium.org>,  "Gustavo A.
 R. Silva" <gustavoars@kernel.org>,  Iurii Zaikin <yzaikin@google.com>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-hardening@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
	<20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231207104357.kndqvzkhxqkwkkjo@localhost>
	<fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
	<20231208095926.aavsjrtqbb5rygmb@localhost>
	<8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
	<ZXlhkJm2KjCymcqu@bombadil.infradead.org>
Date: Wed, 13 Dec 2023 12:18:00 -0600
In-Reply-To: <ZXlhkJm2KjCymcqu@bombadil.infradead.org> (Luis Chamberlain's
	message of "Tue, 12 Dec 2023 23:47:28 -0800")
Message-ID: <87v8927yqv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1rDTo9-007oxM-1R;;;mid=<87v8927yqv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19i6qfGdObJtlqwV73cM5HlVuthNRxr54M=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 472 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.41
	(0.3%), extract_message_metadata: 26 (5.5%), get_uri_detail_list: 2.4
	(0.5%), tests_pri_-2000: 39 (8.3%), tests_pri_-1000: 4.2 (0.9%),
	tests_pri_-950: 1.79 (0.4%), tests_pri_-900: 1.50 (0.3%),
	tests_pri_-90: 133 (28.2%), check_bayes: 132 (27.9%), b_tokenize: 12
	(2.6%), b_tok_get_all: 9 (2.0%), b_comp_prob: 4.2 (0.9%),
	b_tok_touch_all: 102 (21.6%), b_finish: 0.96 (0.2%), tests_pri_0: 238
	(50.4%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 2.8
	(0.6%), poll_dns_idle: 1.21 (0.3%), tests_pri_10: 2.3 (0.5%),
	tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Mon, Dec 11, 2023 at 12:25:10PM +0100, Thomas Wei=C3=9Fschuh wrote:
>> Before sending it I'd like to get feedback on the internal rework of the
>> is_empty detection from you and/or Luis.
>>=20
>> https://git.sr.ht/~t-8ch/linux/commit/ea27507070f3c47be6febebe451bbb88f6=
ea707e
>> or the attached patch.
>
> Please send as a new patch as RFC and please ensure on the To field is
> first "Eric W. Biederman" <ebiederm@xmission.com> with a bit more
> elaborate commit log as suggested from my review below. If there are
> any hidden things me and Joel could probably miss I'm sure Eric will
> be easily able to spot it.
>
>> From ea27507070f3c47be6febebe451bbb88f6ea707e Mon Sep 17 00:00:00 2001
>> From: =3D?UTF-8?q?Thomas=3D20Wei=3DC3=3D9Fschuh?=3D <linux@weissschuh.ne=
t>
>> Date: Sun, 3 Dec 2023 21:56:46 +0100
>> Subject: [PATCH] sysctl: move permanently empty flag to ctl_dir
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>=20
>> Simplify the logic by always keeping the permanently_empty flag on the
>> ctl_dir.
>> The previous logic kept the flag in the leaf ctl_table and from there
>> transferred it to the ctl_table from the directory.
>>=20
>> This also removes the need to have a mutable ctl_table and will allow
>> the constification of those structs.

> Please elaborate a bit more on this here in your next RFC.

> It's a pretty aggressive cleanup, specially with the new hipster guard()
> call but I'd love Eric's eyeballs on a proper v2.

I will look at a v2 time permitting.

My sense is that changing the locking probably make sense as a separate
patch.

Eric

