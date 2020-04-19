Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75ED1AF66F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 05:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDSD2L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 23:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgDSD2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 23:28:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D73C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 20:28:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 21E812A1235
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2] unicode: implement utf8 unit tests as a KUnit test suite.
Organization: Collabora
References: <20200416150716.3561-1-ricardo.canuelo@collabora.com>
Date:   Sat, 18 Apr 2020 23:28:03 -0400
In-Reply-To: <20200416150716.3561-1-ricardo.canuelo@collabora.com> ("Ricardo
        =?utf-8?Q?Ca=C3=B1uelo=22's?= message of "Thu, 16 Apr 2020 17:07:16 +0200")
Message-ID: <853690xigs.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ricardo Cañuelo <ricardo.canuelo@collabora.com> writes:

> This translates the existing utf8 unit test module into a KUnit-compliant
> test suite. No functionality has been added or removed.
>
> Some names changed to make the file name, the Kconfig option and test
> suite name less specific, since this source file might hold more utf8
> tests in the future.
>
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>

Thanks, applied with a small checkpatch.pl fix.

-- 
Gabriel Krisman Bertazi
