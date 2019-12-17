Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E24122C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLQM4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 07:56:39 -0500
Received: from mail3.bemta25.messagelabs.com ([195.245.230.88]:59851 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLQM4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1576587396; i=@ts.fujitsu.com;
        bh=fpkvNtzpSQbdWK6I0VIWWEXa6W4Wxi8aXY9BJ5Mg5Q0=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=RdeM+gcVOTFvbn2ck8Nmca1G7PZ5vVFdGPIDvyrKHtvuppCa7jicgMjLOClcOVg0N
         Rx2jTXpWS+Q1LeARetPUzvIWIjdn3TIvGeyEWKQAo9H1kDai8mVW98Vg8EEoi7eFkD
         2E8vlW6dKIYGkJ2KGYAIPnkpzwsK5z0gCECJjpq6TiE58EXxIR7JwGosAsDWJvY/kn
         baUhkqXs7uUi0pjYm3kXI/fZBPgxudDw1dBc9c7gPjYqF7bFv5cYmbk+ZWz42Gu+vz
         Zc1hEryQEvwR7Zg0zkX2oHkDV9+hrXpDp/tXNg9oa/3xuSnJAEepVokVXGNlirkMjf
         RRAlZQ4zPw/+Q==
Received: from [46.226.52.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-8.bemta.az-b.eu-west-1.aws.symcld.net id FF/4B-22072-380D8FD5; Tue, 17 Dec 2019 12:56:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRWlGSWpSXmKPExsViZ8MRqtt84Ue
  swZULChbHJ1ha7Nl7ksXi8q45bBaTOo+xObB4tGyO9ph3MtDj8ya5AOYo1sy8pPyKBNaM0zP1
  C16wV3TemMXSwLiSrYuRi0NIYA6jxJkTf1kgnHmMEquOXmDtYuTkYBMwkNj16hAziC0ioCzx5
  MB6MJtZIENi74XnTCC2sICHxOa9bxlBbBYBVYlrW96AxXkFDCVOrTwGVs8poCvx+OY+dhBbSC
  BIYsrzxYwQNYISJ2c+YYGYKS/RcbmRFcLWkViw+xPbBEbeWUjKZiEpm4WkbAEj8ypGi6SizPS
  MktzEzBxdQwMDXUNDI11DSzNdIwMjvcQq3SS91FLd8tTiEl1DvcTyYr3iytzknBS9vNSSTYzA
  AE0pOHJqB+Ohr2/1DjFKcjApifK+3fkjVogvKT+lMiOxOCO+qDQntfgQowwHh5IE779zQDnBo
  tT01Iq0zBxgtMCkJTh4lER4Oc8DpXmLCxJzizPTIVKnGBWlxHlngfQJgCQySvPg2mAReolRVk
  qYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK8TyBSezLwSuOmvgBYzAS028vsGsrgkESEl1cAU83r
  CNDHW5HrPp8Lcp60OT2SNN3TaNOW5peC9LVzr918N/JRRqucWdmXJEXlrkeqdyuvfd/32cHnj
  +C/++4e8mERx5d09T4smf193+ibDrpxrmf8SQ9zM99u/0fyzpHPTpA7r4wobL59jFSqZb3zWN
  PjKl53lbJEZ4Zesml6UfOer1LobFP73weNVRdYP/143Pi9autHWUjzh9rtZ9lGcBxsnnJ6921
  BnCb/O7eimr3d2Z9r+MWnfte79Fe8lxxRT7rNNvPTBennWvtjm27nnZTUXcU5dM9lCdE/c3hq
  Vz1z5Nb6tMz9JmGtct5qp2KBXG62geVb++szaMwce/qyYq3boyYP27WoWwisf2vWdUGIpzkg0
  1GIuKk4EAF2F0T1LAwAA
X-Env-Sender: dietmar.hahn@ts.fujitsu.com
X-Msg-Ref: server-2.tower-285.messagelabs.com!1576587395!675162!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24937 invoked from network); 17 Dec 2019 12:56:35 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-2.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Dec 2019 12:56:35 -0000
Received: from sanpedro.mch.fsc.net ([172.17.20.6])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id xBHCuYMe013636;
        Tue, 17 Dec 2019 12:56:34 GMT
Received: from amur.mch.fsc.net (unknown [10.172.102.15])
        by sanpedro.mch.fsc.net (Postfix) with ESMTP id 1B9F5AB1D3A;
        Tue, 17 Dec 2019 13:56:26 +0100 (CET)
From:   Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Fix a panic when core_pattern is set to "| prog..."
Date:   Tue, 17 Dec 2019 13:56:25 +0100
Message-ID: <7309912.xQAL2Br30t@amur.mch.fsc.net>
In-Reply-To: <87r214unfw.fsf@linux.intel.com>
References: <2996767.y7E8ffpIOs@amur.mch.fsc.net> <87r214unfw.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Montag, 16. Dezember 2019, 19:37:07 CET schrieb Andi Kleen:
> Dietmar Hahn <dietmar.hahn@ts.fujitsu.com> writes:
> 
> > Hi,
> >
> > if the /proc/sys/kernel/core_pattern is set with a space between '|' and the
> > program and later a core file should be written the kernel panics.
> > This happens because in format_corename() the first part of cn.corename
> > is set to '\0' and later call_usermodehelper_exec() exits because of an
> > empty command path but with return 0. But no pipe is created and thus
> > cprm.file == NULL.
> > This leads in file_start_write() to the panic because of dereferencing
> > file_inode(file)->i_mode.
> 
> It would seem better to just skip the spaces and DTRT?

This would be the normal case but the mistake happened accidently. And I was
really surprised to see the system panic after the segfault of a user program.
And it took a little bit time to find the cause ...

Dietmar.
 
> Of course doing the error check properly is a good idea anyways.
> 
> -Andi




