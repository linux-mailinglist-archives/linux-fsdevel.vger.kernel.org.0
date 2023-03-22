Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF99B6C4A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCVM1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCVM13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:27:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFE28E47;
        Wed, 22 Mar 2023 05:27:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhSR23Twmz4xFZ;
        Wed, 22 Mar 2023 23:27:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230310232850.3960676-1-mcgrof@kernel.org>
References: <20230310232850.3960676-1-mcgrof@kernel.org>
Subject: Re: [PATCH 0/2] ppc: simplify sysctl registration
Message-Id: <167948793444.559204.3802967683451092052.b4-ty@ellerman.id.au>
Date:   Wed, 22 Mar 2023 23:25:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Mar 2023 15:28:48 -0800, Luis Chamberlain wrote:
> We can simplify the way we do sysctl registration both by
> reducing the number of lines and also avoiding calllers which
> could do recursion. The docs are being updated to help reflect
> this better [0].
> 
> [0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u
> 
> [...]

Applied to powerpc/next.

[1/2] ppc: simplify one-level sysctl registration for powersave_nap_ctl_table
      https://git.kernel.org/powerpc/c/bfedee5dc406ddcd70d667be1501659f1b232b7f
[2/2] ppc: simplify one-level sysctl registration for nmi_wd_lpm_factor_ctl_table
      https://git.kernel.org/powerpc/c/3a713753d3cb52e4e3039cdb906ef00f0b574219

cheers
