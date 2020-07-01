Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7805210204
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 04:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGAC0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 22:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGAC0d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:26:33 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D7B2073E;
        Wed,  1 Jul 2020 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593570392;
        bh=3MljW59SXvwa7bhT/OQO01+UNW6pNEpuKLpJw1nBH2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v8SA4Jwdp74xVT0YW9LoMdzqV6Tov5mZJ3dlee41GLx1gB11rUkrZJTZUUC58vuKj
         +JpNfJ3wjrxkNZ7iWNZsXn2ORS7MX39YR9pLoCD4L+uXR5gi07qhuBEEG2ERmMzSaL
         QTF91J/fO53a85b7cgP6I3BNu/V1wdV8+0slXpKw=
Date:   Tue, 30 Jun 2020 19:26:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lepton Wu <ytht.net@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] coredump: Add %f for executable file name.
Message-Id: <20200630192631.612f79b6226b36630c1429de@linux-foundation.org>
In-Reply-To: <20200627042303.1216506-1-ytht.net@gmail.com>
References: <20200627040100.1211301-1-ytht.net@gmail.com>
        <20200627042303.1216506-1-ytht.net@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 26 Jun 2020 21:23:03 -0700 Lepton Wu <ytht.net@gmail.com> wrote:

> The document reads "%e" should be executable file name while actually
> it could be changed by things like pr_ctl PR_SET_NAME. We can't really
> change the behavior of "%e" for now, so introduce a new "%f" for the
> real executable file name.

Please explain (in as much detail as possible) why you believe the
kernel should be changed in this way.
