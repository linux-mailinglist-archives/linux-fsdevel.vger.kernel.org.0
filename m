Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F885519A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbiEDIme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346447AbiEDImc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:42:32 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092D1EC5E
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:38:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id A233DC0111
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 10:38:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gedUdIC5KYT4 for <linux-fsdevel@vger.kernel.org>;
        Wed,  4 May 2022 10:38:46 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 8375EC00E1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 10:38:46 +0200 (CEST)
Received: (qmail 29461 invoked from network); 4 May 2022 14:31:48 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 4 May 2022 14:31:48 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 52E234609CE; Wed,  4 May 2022 10:38:46 +0200 (CEST)
Date:   Wed, 4 May 2022 10:38:46 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fscache corruption in Linux 5.17?
Message-ID: <YnI7lgazkdi6jcve@rabbit.intern.cm-ag>
References: <Yl75D02pXj71kQBx@rabbit.intern.cm-ag>
 <Yl7d++G25sNXIR+p@rabbit.intern.cm-ag>
 <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
 <507518.1650383808@warthog.procyon.org.uk>
 <509961.1650386569@warthog.procyon.org.uk>
 <705278.1650462934@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705278.1650462934@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/04/20 15:55, David Howells <dhowells@redhat.com> wrote:
> I have a tentative patch for this - see attached.

Quick feedback: your patch has been running on our servers for two
weeks, and I have received no new complaints about corrupted files.
That doesn't prove the patch is correct or that it really solves my
problem, but anyway it's a good sign.  Thanks so far.

Max
