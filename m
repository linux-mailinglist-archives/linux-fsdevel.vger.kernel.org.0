Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547BF22107B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGOPI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 11:08:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50333 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgGOPI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:08:57 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvj1T-0003xb-Lh; Wed, 15 Jul 2020 15:08:39 +0000
Date:   Wed, 15 Jul 2020 17:08:38 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] pid_namespace: use
 checkpoint_restore_ns_capable() for ns_last_pid
Message-ID: <20200715150838.rcmv73bkvhf35zuz@wittgenstein>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200715144954.1387760-4-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715144954.1387760-4-areber@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:49:51PM +0200, Adrian Reber wrote:
> Use the newly introduced capability CAP_CHECKPOINT_RESTORE to allow
> writing to ns_last_pid.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
