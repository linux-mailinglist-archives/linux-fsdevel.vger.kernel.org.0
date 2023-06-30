Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3615A7437C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjF3Iwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjF3Iwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:52:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4AD2100;
        Fri, 30 Jun 2023 01:52:38 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MkpnF-1pl5BI3GhT-00mGBb; Fri, 30 Jun 2023 10:52:23 +0200
Message-ID: <e8161622-beb0-d8d5-6501-f0bee76a372d@vivier.eu>
Date:   Fri, 30 Jun 2023 10:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: fr, en-US
To:     Norbert Lange <nolange79@gmail.com>, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, jan.kiszka@siemens.com,
        jannh@google.com, avagin@gmail.com, dima@arista.com,
        James.Bottomley@HansenPartnership.com
References: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
 <20230630083852.3988-1-norbert.lange@andritz.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
In-Reply-To: <20230630083852.3988-1-norbert.lange@andritz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e0YVNPL0r25RhOFx81Dnim/E7wqoqapfwh5+mxSQ2y8mxgc/ajI
 IXHGv6dVnjSR2J2yewBHLQxG7IUtrF3fOt7Dqj+G5M9E3UmrtGDiQKD1s6cOAOKzRxAI8GG
 +ro7bLchVrJVP4K/HPxJatjZllsMyom+tTm1pXRJK9Z1bkIhoV9uM7Niv+mXfHEBc1TI8Dd
 H9f69gj+F8sF2VXwqgWiw==
UI-OutboundReport: notjunk:1;M01:P0:ai4mzwQsgpU=;hJrSFSuBsuOtuwp59dlcpD2YVc4
 etrQ2kmTxCMTW+2edqAn2hvCBkejUrqhiAFlqN6BDEnvtji6gDpqZYPEsX9OwTdi3psh33Jv4
 lxSvI82WgiS/segrEGUzB3ywHVC4BSPyGqdp2WeOFzU2qacl2p0KW5xrdi/7gVhMIO5XYZjGC
 lixQlstRUMr3wsK6xU9GAOWNMSx9I35e0pW5V1Hxq8Fu14zvQjpBGN7czQeibi2TAbPipoU3I
 gGzBTFOFj9RfTkbfe5A4wr63u9/YwBkezg+jVf1vKFgA41w0xhJR2rm/Ik4sBT1KXAhdxsBiV
 caI2x2Lp/sLUIaxEKWF85d3wh4T5F/fBNgW06wAoVG95zbqaOyaMrtdmQb6qpYyrSOEDMC74o
 SOBDeCnQdGIFlCtxdnZtNkKRTkmWEz98fg6NXVEbsvp34ncA3d3iCRmd13K07eiJ2DH8noDKw
 KBsA4A4NO/pO+Lu9QsokOtzhU5hyOUbV519KnE9B85ukmKlrXrQFVQSBtUuX8aiule9VYfqkw
 OA8zQOLZFKf3PmQgiA3VPlAypQ6kIoEd3eo/y+WF5dUgLdzCDRlsytb1pkAJQ3ACUp+6JwZoB
 KTBF09xS4HgohyZwcG2OuKWA/g3rqJHHsEtiM6tthzFoEBfrCiNC6GCXmdhVP6MN2KYKdZ7Hc
 mlPdNnu+jzfH5+X8uhBsP2FAn2ql5Hk7YcRjXpEPcw==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Norbert,

Le 30/06/2023 à 10:38, Norbert Lange a écrit :
> Any news on this? What remains to be done, who needs to be harrassed?
> 
> Regards, Norbert

Christian was working on a new version but there is no update for 1 year.

[PATCH v2 1/2] binfmt_misc: cleanup on filesystem umount
https://lkml.org/lkml/2021/12/16/406
[PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
https://lkml.org/lkml/2021/12/16/407

And personally I don't have the time to work on this.

Thanks,
Laurent
