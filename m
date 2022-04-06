Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5714F6268
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiDFPAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiDFPAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:00:31 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00D591CEA63;
        Tue,  5 Apr 2022 21:44:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 22B1910E569C;
        Wed,  6 Apr 2022 14:44:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nbxXD-00EKDN-Rn; Wed, 06 Apr 2022 14:44:47 +1000
Date:   Wed, 6 Apr 2022 14:44:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: cross mount reflink and xfstest generic/373
Message-ID: <20220406044447.GD1609613@dread.disaster.area>
References: <CAH2r5muFq-4J=uedVF9qdYmFzgDDPwuYD+zrLytjUJE+APcBow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muFq-4J=uedVF9qdYmFzgDDPwuYD+zrLytjUJE+APcBow@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=624d1ac4
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=ysp4cIzfheLsl-icjhIA:9 a=CjuIK1q_8ugA:10
        a=qR24C9TJY6iBuJVj_x8Y:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 11:48:29AM -0500, Steve French wrote:
> I like the patch which allows cross mount reflink (since in some cases
> like SMB3 mounts, cross mount reflink can now work depending on the
> volumes exported by the server) but was wondering if that means test
> generic/373 is getting any changes.  In our test setup the btrfs
> directories we export over SMB3.1.1 for SCRATCH and TEST were on the
> partition on the server so reflink now works where test 373 expected
> them to fail.  I can change our test setup to make sure SCRATCH and
> TEST are different volumes or server but was wondering if any recent
> changes to reflink related xfstests
> 
> commit 9f5710bbfd3031dd7ce244fa26fba896d35f5342
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Fri Feb 18 09:38:14 2022 -0500
> 
>     fs: allow cross-vfsmount reflink/dedupe

https://lore.kernel.org/fstests/cover.1648153387.git.josef@toxicpanda.com/

-Dave.
-- 
Dave Chinner
david@fromorbit.com
