Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDA1158D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 22:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFVx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 16:53:29 -0500
Received: from freki.datenkhaos.de ([81.7.17.101]:59500 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFVx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:53:29 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 16:53:27 EST
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 0EEA01E3A722;
        Fri,  6 Dec 2019 22:47:36 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3vv8b2g8ZfmA; Fri,  6 Dec 2019 22:47:30 +0100 (CET)
Received: from latitude (x4db74696.dyn.telefonica.de [77.183.70.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Fri,  6 Dec 2019 22:47:30 +0100 (CET)
Date:   Fri, 6 Dec 2019 22:47:25 +0100
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
Message-ID: <20191206214725.GA2108@latitude>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019 Okt 23, David Howells wrote:
> Convert pipes to use head and tail pointers for the buffer ring rather than
> pointer and length as the latter requires two atomic ops to update (or a
> combined op) whereas the former only requires one.

This change breaks firefox on my system. I've noticed that some pages
doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
start loading and than stop. Looks like firefox is waiting for some
dynamic loading content. I've bisected to this commit, but can't revert
because of conflicts.

-- 
Regards,
  Johannes Hirte

