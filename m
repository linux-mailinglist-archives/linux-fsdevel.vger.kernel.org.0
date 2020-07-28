Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61A3231068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgG1RFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:05:36 -0400
Received: from namei.org ([65.99.196.166]:55950 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RFg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:05:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06SH58V8001021;
        Tue, 28 Jul 2020 17:05:08 GMT
Date:   Wed, 29 Jul 2020 03:05:08 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     madvenka@linux.microsoft.com, kernel-hardening@lists.openwall.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
In-Reply-To: <3fd22f92-7f45-1b0f-e4fe-857f3bceedd0@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.2007290300400.31310@namei.org>
References: <aefc85852ea518982e74b233e11e16d2e707bc32> <20200728131050.24443-1-madvenka@linux.microsoft.com> <3fd22f92-7f45-1b0f-e4fe-857f3bceedd0@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Jul 2020, Casey Schaufler wrote:

> You could make a separate LSM to do these checks instead of limiting
> it to SELinux. Your use case, your call, of course.

It's not limited to SELinux. This is hooked via the LSM API and 
implementable by any LSM (similar to execmem, execstack etc.)


-- 
James Morris
<jmorris@namei.org>

