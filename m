Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439F617B82D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 09:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgCFIPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 03:15:40 -0500
Received: from albireo.enyo.de ([37.24.231.21]:54478 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCFIPk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:15:40 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jA88n-0008VD-Dn; Fri, 06 Mar 2020 08:15:29 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jA87C-0001li-5M; Fri, 06 Mar 2020 09:13:50 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     YunQiang Su <syq@debian.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
References: <20200306080905.173466-1-syq@debian.org>
Date:   Fri, 06 Mar 2020 09:13:50 +0100
In-Reply-To: <20200306080905.173466-1-syq@debian.org> (YunQiang Su's message
        of "Fri, 6 Mar 2020 16:09:05 +0800")
Message-ID: <87r1y53npd.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* YunQiang Su:

> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS, flags);

Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
separate AT_ tag dedicated to binfmt_misc.
