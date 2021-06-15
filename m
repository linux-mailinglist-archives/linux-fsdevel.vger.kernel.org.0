Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B543A7D50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 13:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFOLhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 07:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhFOLhb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A015B61107;
        Tue, 15 Jun 2021 11:35:25 +0000 (UTC)
Date:   Tue, 15 Jun 2021 13:35:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/5] kernel/pid.c: implement additional checks upon
 pidfd_create() parameters
Message-ID: <20210615113522.kasddqrm6sedn5tj@wittgenstein>
References: <cover.1623282854.git.repnop@google.com>
 <3020418a466bc3f4e90413c3c98c29a1a93fd59f.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3020418a466bc3f4e90413c3c98c29a1a93fd59f.1623282854.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:20:43AM +1000, Matthew Bobrowski wrote:
> By adding the pidfd_create() declaration to linux/pid.h, we
> effectively expose this function to the rest of the kernel. In order
> to avoid any unintended behaviour, or set false expectations upon this
> function, ensure that constraints are forced upon each of the passed
> parameters. This includes the checking of whether the passed struct
> pid is a thread-group leader as pidfd creation is currently limited to
> such pid types.
> 
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
