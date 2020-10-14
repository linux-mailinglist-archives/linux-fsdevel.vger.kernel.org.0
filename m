Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344B28E80E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbgJNUrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 16:47:09 -0400
Received: from namei.org ([65.99.196.166]:35652 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387909AbgJNUrJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:47:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 09EKkLrU004034;
        Wed, 14 Oct 2020 20:46:21 GMT
Date:   Thu, 15 Oct 2020 07:46:21 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v21 07/12] landlock: Support filesystem access-control
In-Reply-To: <b311a2a6-5290-5c50-3a9c-4d5b54b6b406@digikod.net>
Message-ID: <alpine.LRH.2.21.2010150746120.4000@namei.org>
References: <20201008153103.1155388-1-mic@digikod.net> <20201008153103.1155388-8-mic@digikod.net> <alpine.LRH.2.21.2010150504360.26012@namei.org> <77ea263c-4200-eb74-24b2-9a8155aff9b5@digikod.net> <b311a2a6-5290-5c50-3a9c-4d5b54b6b406@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1392177967-1602708383=:4000"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1392177967-1602708383=:4000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 14 Oct 2020, Mickaël Salaün wrote:

> 
> On 14/10/2020 20:52, Mickaël Salaün wrote:
> > 
> > On 14/10/2020 20:07, James Morris wrote:
> >> On Thu, 8 Oct 2020, Mickaël Salaün wrote:
> >>
> >>> +config ARCH_EPHEMERAL_STATES
> >>> +	def_bool n
> >>> +	help
> >>> +	  An arch should select this symbol if it does not keep an internal kernel
> >>> +	  state for kernel objects such as inodes, but instead relies on something
> >>> +	  else (e.g. the host kernel for an UML kernel).
> >>> +
> >>
> >> This is used to disable Landlock for UML, correct?
> > 
> > Yes
> > 
> >> I wonder if it could be 
> >> more specific: "ephemeral states" is a very broad term.
> >>
> >> How about something like ARCH_OWN_INODES ?
> > 
> > Sounds good. We may need add new ones (e.g. for network socket, UID,
> > etc.) in the future though.
> > 
> 
> Because UML is the exception here, it would be more convenient to keep
> the inverted semantic. What about ARCH_NO_OWN_INODES or
> ARCH_EPHEMERAL_INODES?

The latter seems good.

-- 
James Morris
<jmorris@namei.org>

--1665246916-1392177967-1602708383=:4000--
