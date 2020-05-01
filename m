Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992F71C1C94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgEASHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 14:07:23 -0400
Received: from namei.org ([65.99.196.166]:56664 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgEASHX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 14:07:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 041I5rjc006112;
        Fri, 1 May 2020 18:05:53 GMT
Date:   Sat, 2 May 2020 04:05:53 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] fs: Enable to enforce noexec mounts or file exec
 through RESOLVE_MAYEXEC
In-Reply-To: <d1a81d06-7530-1f2b-858a-e42bc1ae2a7e@digikod.net>
Message-ID: <alpine.LRH.2.21.2005020405210.5924@namei.org>
References: <20200428175129.634352-1-mic@digikod.net> <20200428175129.634352-4-mic@digikod.net> <alpine.LRH.2.21.2005011409570.29679@namei.org> <d1a81d06-7530-1f2b-858a-e42bc1ae2a7e@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1237382289-1588356355=:5924"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1237382289-1588356355=:5924
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, Mickaël Salaün wrote:

> 
> However, for fully controlled distros such as CLIP OS, it make sense to
> enforce such restrictions at kernel build time. I can add an alternative
> kernel configuration to enforce a particular policy at boot and disable
> this sysctl.

Sounds good.

-- 
James Morris
<jmorris@namei.org>

--1665246916-1237382289-1588356355=:5924--
