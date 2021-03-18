Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62FB3403DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 11:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCRKuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 06:50:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33681 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCRKtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:49:40 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMqDe-0006xL-AL; Thu, 18 Mar 2021 10:49:34 +0000
Date:   Thu, 18 Mar 2021 11:49:32 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] audit: add support for openat2
Message-ID: <20210318104932.5225mmecww2fd4zw@wittgenstein>
References: <cover.1616031035.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1616031035.git.rgb@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:47:16PM -0400, Richard Guy Briggs wrote:
> The openat2(2) syscall was added in v5.6.  Add support for openat2 to the
> audit syscall classifier and for recording openat2 parameters that cannot
> be captured in the syscall parameters of the SYSCALL record.
> 
> Supporting userspace code can be found in
> https://github.com/rgbriggs/audit-userspace/tree/ghau-openat2
> 
> Supporting test case can be found in
> https://github.com/linux-audit/audit-testsuite/pull/103

Seems sensible, thank you.
