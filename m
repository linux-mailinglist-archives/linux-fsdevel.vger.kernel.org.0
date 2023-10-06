Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B947BBFD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjJFTt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:49:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8C583;
        Fri,  6 Oct 2023 12:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F60DC433C8;
        Fri,  6 Oct 2023 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696621797;
        bh=Hx+Hx3Wfpt2A/Fub/PCNT6xbQsKG/wFAjDrEGs3P26w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUmqoCPWchauDSaSmD1GaOCjly7zA1gRY2TKMSipidPhwhUoAov8RT1EEWvAv13tI
         ohM5/5mL2fDXiW3iNZz4Y52/8WwYioaK0Qh+5l3rlSdTjBLDelN+zzI2zpyW2m3cEQ
         mWQnZRbkMrIQLkbs7QO/RPf9w56//HZ8hcqdGOkaLRuAiysxw9Fe2Xj5Pkpp0lYNbm
         Q3kRdxdYfZNaIAaloCcBWEJ4WIJw5Blx4Dsh0NfAeGwL+9817dLnr55vOoiUBbkTX2
         UJIuhlpVbBTXOSLk3uCzmZX1Ev6228wqtOgiTGF3eLddKkqB+x/hf3BTtUQ7mbBxzz
         C92RbvJU0CieQ==
Date:   Fri, 6 Oct 2023 21:49:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Mark Brown <broonie@kernel.org>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Test failure from "file: convert to SLAB_TYPESAFE_BY_RCU"
Message-ID: <20231006-altmodisch-erhielten-3beaa62c57f7@brauner>
References: <00e5cc23-a888-46ce-8789-fc182a2131b0@sirena.org.uk>
 <yt9dil7k151d.fsf@linux.ibm.com>
 <ZR//+QDRI3sBpqY4@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZR//+QDRI3sBpqY4@f>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 06, 2023 at 02:39:21PM +0200, Mateusz Guzik wrote:
> On Fri, Oct 06, 2023 at 11:19:58AM +0200, Sven Schnelle wrote:
> > I'm seeing the same with the strace test-suite on s390. The problem is
> > that /proc/*/fd now contains the file descriptors of the calling
> > process, and not the target process.
> > 
> 
> This is why:

Yes, I realized this right when I had to take a ride for 5h. Just fixed
this a while ago and ran selftests as well. Thanks for digging into it
as well.
