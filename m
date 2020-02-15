Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFCB15FF0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgBOPpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 10:45:01 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53224 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgBOPpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 10:45:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 974FE8EE302;
        Sat, 15 Feb 2020 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781500;
        bh=8BdQtl6J59gHpnTgJx1w9OBE3CusPmGEQ8xUMldqtPU=;
        h=Subject:From:To:Cc:Date:From;
        b=cCyWw8XJNVS4P9rxbrYpr3NVke8eqqgzi05Gr8uYoPuFwrehLAg+XZvSmWhEW0+Jv
         OOkfMadAB2Cd8d4ZjOIykWqhU478rLsr0Zs7tHB+q+yh2HAt3Zly5VxU25KIl6TObi
         GuZ7sdDb/D+SNVc1sMQvexhRGDxn5OQNBM3AyP3k=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eyYLxwU_i8N1; Sat, 15 Feb 2020 07:45:00 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5C7B68EE121;
        Sat, 15 Feb 2020 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581781500;
        bh=8BdQtl6J59gHpnTgJx1w9OBE3CusPmGEQ8xUMldqtPU=;
        h=Subject:From:To:Cc:Date:From;
        b=cCyWw8XJNVS4P9rxbrYpr3NVke8eqqgzi05Gr8uYoPuFwrehLAg+XZvSmWhEW0+Jv
         OOkfMadAB2Cd8d4ZjOIykWqhU478rLsr0Zs7tHB+q+yh2HAt3Zly5VxU25KIl6TObi
         GuZ7sdDb/D+SNVc1sMQvexhRGDxn5OQNBM3AyP3k=
Message-ID: <1581781497.3847.5.camel@HansenPartnership.com>
Subject: [LSF/MM/BPF Topic] Lets have the Interface debate: configfd vs
 fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        lsf-pc@lists.linux-foundation.org
Date:   Sat, 15 Feb 2020 10:44:57 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've made the case in email that interfaces should always be as general
as they can be.  The counter argument is that interfaces which are too
general can be too powerful and hard for containment logic, like
seccomp, to properly constrain and predict the outcomes from the
various parameters.  So lets have that debate.  My argument is that
essentially we're good enough to handle the power wisely and we can
design interfaces, like configfd, to have easy introspection properties
for confinement tools, and I'm happy to debate this with anyone on the
less power makes easier interfaces side.

James

