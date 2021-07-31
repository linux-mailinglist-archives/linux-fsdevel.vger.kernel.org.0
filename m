Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED93DC647
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhGaOX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 10:23:59 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58704 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhGaOXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 10:23:17 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9prE-005VEI-Af; Sat, 31 Jul 2021 14:20:56 +0000
Date:   Sat, 31 Jul 2021 14:20:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: use 'unsigned int' instead of 'unsigned'
Message-ID: <YQVcSCxlpvh6yPAM@zeniv-ca.linux.org.uk>
References: <20210731130957.416337-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731130957.416337-1-wangborong@cdjrlc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 31, 2021 at 09:09:57PM +0800, Jason Wang wrote:
> Prefer 'unsigned int' to bare use of 'unsigned'.

Same question.
