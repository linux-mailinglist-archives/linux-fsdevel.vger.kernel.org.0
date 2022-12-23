Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120F654DE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLWIwH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 03:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWIwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:52:05 -0500
Received: from herc.mirbsd.org (herc.mirbsd.org [IPv6:2001:470:1f15:10c:202:b3ff:feb7:54e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88488357BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Dec 2022 00:52:03 -0800 (PST)
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 2BN8nVMY005094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 23 Dec 2022 08:49:33 GMT
Date:   Fri, 23 Dec 2022 08:49:31 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Donald Buczek <buczek@molgen.mpg.de>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, 1024811@bugs.debian.org
Subject: Re: Bug#1024811: linux: /proc/[pid]/stat unparsable
In-Reply-To: <b3ed92e0-6135-7f0c-6b6b-1be9dfe7a8a1@molgen.mpg.de>
Message-ID: <Pine.BSM.4.64L.2212230847310.9463@herc.mirbsd.org>
References: <166939644927.12906.17757536147994071219.reportbug@x61w.mirbsd.org>
 <Y4Hshbyk9TEsSQsm@p183> <d1f6877d-a084-2099-5764-979ee163eace@evolvis.org>
 <a721c273-9724-a652-1888-9c5d5ece7661@molgen.mpg.de>
 <Pine.BSM.4.64L.2212222023170.29938@herc.mirbsd.org>
 <b3ed92e0-6135-7f0c-6b6b-1be9dfe7a8a1@molgen.mpg.de>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Donald Buczek dixit:

> To be fair, this daemon doesn't use /proc/pid/stat for that, but /proc/pid/comm

Yes, and that’s proper. The field in /proc/pid/stat is size-limited
and so not necessarily distinct.

> As /proc/pid/stat is also used in many places, it could as well use
> that to avoid code duplication or reuse data already read from the
> other source.

No, because the data in /stat is incomplete *and* anything using
it that would be affected by escaping was already broken.

bye,
//mirabilos
-- 
22:20⎜<asarch> The crazy that persists in his craziness becomes a master
22:21⎜<asarch> And the distance between the craziness and geniality is
only measured by the success 18:35⎜<asarch> "Psychotics are consistently
inconsistent. The essence of sanity is to be inconsistently inconsistent
