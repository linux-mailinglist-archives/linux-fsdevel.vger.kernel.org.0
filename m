Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5617B86A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 09:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFIjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 6 Mar 2020 03:39:18 -0500
Received: from albireo.enyo.de ([37.24.231.21]:54812 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFIjS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:39:18 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jA8Vi-0000GF-K5; Fri, 06 Mar 2020 08:39:10 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jA8U7-00026r-DL; Fri, 06 Mar 2020 09:37:31 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     YunQiang Su <syq@debian.org>, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
References: <20200306080905.173466-1-syq@debian.org>
        <87r1y53npd.fsf@mid.deneb.enyo.de>
        <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
Date:   Fri, 06 Mar 2020 09:37:31 +0100
In-Reply-To: <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu> (Laurent
        Vivier's message of "Fri, 6 Mar 2020 09:21:46 +0100")
Message-ID: <87mu8t3mlw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Laurent Vivier:

> Le 06/03/2020 à 09:13, Florian Weimer a écrit :
>> * YunQiang Su:
>> 
>>> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
>>> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
>>> +	NEW_AUX_ENT(AT_FLAGS, flags);
>> 
>> Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
>> separate AT_ tag dedicated to binfmt_misc.
>
> Not necessary, but it seemed simpler and cleaner to re-use a flag that
> is marked as unused and with a name matching the new role. It avoids to
> patch other packages (like glibc) to add it as it is already defined.

You still need to define AT_FLAGS_PRESERVE_ARGV0.  At that point, you
might as well define AT_BINFMT and AT_BINFMT_PRESERVE_ARGV0.
