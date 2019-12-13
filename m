Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236C311EB6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 21:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfLMT7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 14:59:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44550 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728696AbfLMT7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:59:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7C98D8EE1E0;
        Fri, 13 Dec 2019 11:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576267182;
        bh=vWQDrFNBRvPHrpYiw15uNPAvoQF6Hmi1ReSpXrsHKmM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R6Jl2cP46Dt/doNyUbZYQ0nMg6/WS+m3P2m2g1ghU1uvp1CQ5tFU1cWBjIajdBixd
         IeI8SbzWuq9nbNKI3yJve1NI+7qDuVFkgXglwPteylYSZMYsnR0tDmov2M+bteyeqQ
         0Do3quDEJ1Y3ttBnncgH+Z8ZjJV/jMAYaunBO6pg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3QzNzn626Lyl; Fri, 13 Dec 2019 11:59:40 -0800 (PST)
Received: from [172.20.40.112] (unknown [206.121.240.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B4A078EE0E0;
        Fri, 13 Dec 2019 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576267179;
        bh=vWQDrFNBRvPHrpYiw15uNPAvoQF6Hmi1ReSpXrsHKmM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L+2p7IcjaMeH3psLlUT8aYowCyyHNXyuebIK2ohBWvuDyYaKTV6vGoxrmqJAqpsgD
         uN1cvwl9T1yjmIpTv2lDq2SvWVHJRsCXg6myuI4FdhK4M1y53nK6AmWYIu36J+aUgu
         bUEEkyIemlotbxEI6H3Bm7jynqcOVYWJYg9dCEp8=
Message-ID: <1576267177.4060.4.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 1/1] ns: add binfmt_misc to the user namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Henning Schild <henning.schild@siemens.com>,
        Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>, Jann Horn <jannh@google.com>,
        containers@lists.linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri, 13 Dec 2019 14:59:37 -0500
In-Reply-To: <20191213185110.06b52cf4@md1za8fc.ad001.siemens.net>
References: <20191107140304.8426-1-laurent@vivier.eu>
         <20191107140304.8426-2-laurent@vivier.eu>
         <7cb245ed-f738-7991-a09b-b27152274b9f@vivier.eu>
         <20191213185110.06b52cf4@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-12-13 at 18:51 +0100, Henning Schild wrote:
> Hi all,
> 
> that is a very useful contribution, which will hopefully be
> considered.

I'm technically the maintainer on the you touched it last you own it
basis, so if Christian's concerns get addressed I'll shepherd it
upstream.

James

