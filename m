Return-Path: <linux-fsdevel+bounces-19666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5418C862A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2089B22623
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDA4503A;
	Fri, 17 May 2024 12:13:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3978446D5;
	Fri, 17 May 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947995; cv=none; b=th75XBgsL5uqZ6I2rBiVjTGJMV9kBskwD3VuDHIlIJ6XKmPnyOiKO94Cn9jyYiEvAmftPW0S3lXJXl6Io9SmJjwZzWdbavslvTuVj8BacwqC1WSnKLP/mbuYP+SVER2uYk3DCP41LavCXDVbeambXyLS7gF2ZFXTw5qUAotlv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947995; c=relaxed/simple;
	bh=QY+w7+/xsuNVPLbOX6z71RjMaYe9IzwtylqSW3cExss=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=SCwIwGb1dH2qr9XL6HoqGFmbUU6H4mzUP77tMO3Z1yX7Y6qCAZAjA+jqAdvMUsNaUPNQY8812IEMqgBtaKc3+2toPSaD9wF7XvVtKL7Kc9ej4KqIdRC17ws/5kVMYixMAZ3BXmzKOSocIbtBLGicTnawmidYJQIyY/tC/5AnOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:38640)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1s7vq9-00ELc2-8z; Fri, 17 May 2024 05:33:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56464 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1s7vq7-00HC6p-QA; Fri, 17 May 2024 05:33:32 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: brauner@kernel.org,  Luis Chamberlain <mcgrof@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Joel Granados <j.granados@samsung.com>,  Serge
 Hallyn <serge@hallyn.com>,  Paul Moore <paul@paul-moore.com>,  James
 Morris <jmorris@namei.org>,  David Howells <dhowells@redhat.com>,  Jarkko
 Sakkinen <jarkko@kernel.org>,  containers@lists.linux.dev,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-security-module@vger.kernel.org,  keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
	<20240516092213.6799-2-jcalmels@3xx0.net>
Date: Fri, 17 May 2024 06:32:46 -0500
In-Reply-To: <20240516092213.6799-2-jcalmels@3xx0.net> (Jonathan Calmels's
	message of "Thu, 16 May 2024 02:22:03 -0700")
Message-ID: <878r08brmp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1s7vq7-00HC6p-QA;;;mid=<878r08brmp.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+q9LcYdBDppWToICMQt2uOx8uVr0xZ4BI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4980]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Jonathan Calmels <jcalmels@3xx0.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 587 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 13 (2.1%), b_tie_ro: 11 (1.8%), parse: 1.07
	(0.2%), extract_message_metadata: 14 (2.4%), get_uri_detail_list: 0.73
	(0.1%), tests_pri_-2000: 7 (1.2%), tests_pri_-1000: 3.2 (0.5%),
	tests_pri_-950: 1.38 (0.2%), tests_pri_-900: 1.26 (0.2%),
	tests_pri_-90: 244 (41.5%), check_bayes: 236 (40.2%), b_tokenize: 6
	(0.9%), b_tok_get_all: 6 (1.0%), b_comp_prob: 1.81 (0.3%),
	b_tok_touch_all: 219 (37.4%), b_finish: 1.02 (0.2%), tests_pri_0: 155
	(26.5%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.7
	(0.5%), poll_dns_idle: 129 (22.0%), tests_pri_10: 3.9 (0.7%),
	tests_pri_500: 140 (23.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Jonathan Calmels <jcalmels@3xx0.net> writes:

> Attackers often rely on user namespaces to get elevated (yet confined)
> privileges in order to target specific subsystems (e.g. [1]). Distributions
> have been pretty adamant that they need a way to configure these, most of
> them carry out-of-tree patches to do so, or plainly refuse to enable
> them.

Pointers please?

That sentence sounds about 5 years out of date.

Eric

