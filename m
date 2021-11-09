Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3AC44B440
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 21:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbhKIUt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 15:49:56 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33716 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239911AbhKIUtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=Y1yckhV8f2NZmOsVKhUWwzpqMX8vfzRTxNCsTR573GE=;
        b=nZ74xeAujHm+BlFzcvSjKeg2lMunufqDlvtjhRvKTWGql20xIEb8Ao6PYfZ0iPrj3w8Ops9CU+qnjFKzizfrGBJYehnSLdwKv65U8XxoswVJkycts3/ip6i/spmwHgL3HSUALAQuBnQD99wMohJHyPJbo10+LpcF99vNVEHpoVHovVg7uu1sSxwvzKE46IuqTx8zaojIk1MFnL+0HFcP2ZO1V7/dWaVIebXyxH8govojTbsJKuNsoE9J7+MFAWn4Sy+R/fEXGjYcLdwV4S3mvGYjuX9PgER/rGfyp0z9S5gsqHEdev9WHTBx6qB+wexpuJL6DNqevA7Z3G7HEaKHpg==;
Received: from 201-95-14-182.dsl.telesp.net.br ([201.95.14.182] helo=localhost)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mkXkQ-0000IS-HQ; Tue, 09 Nov 2021 21:29:40 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net, gpiccoli@igalia.com
Subject: [PATCH 0/3] Some improvements on panic_print
Date:   Tue,  9 Nov 2021 17:28:45 -0300
Message-Id: <20211109202848.610874-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everybody, this is a mix of a documentation fix with some additions
to the "panic_print" syscall / parameter. The goal here is being able
to collect all CPUs backtraces during a panic event and also
to enable "panic_print" in a kdump event - details of the reasoning
and design choices in the patches.

Thanks in advance for reviews!
Cheers,


Guilherme


Guilherme G. Piccoli (3):
  docs: sysctl/kernel: Add missing bit to panic_print
  panic: Add option to dump all CPUs backtraces in panic_print
  panic: Allow printing extra panic information on kdump

 Documentation/admin-guide/kernel-parameters.txt |  1 +
 Documentation/admin-guide/sysctl/kernel.rst     |  2 ++
 kernel/panic.c                                  | 11 +++++++++++
 3 files changed, 14 insertions(+)

-- 
2.33.1

