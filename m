Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF6612972
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJ3JcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ3JcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:32:02 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8AB4A8;
        Sun, 30 Oct 2022 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667122318; i=@fujitsu.com;
        bh=J8ip3c20zMY0KVGi6q27oNYbCZxvyY5v1/jCNuRGLz0=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=r1kAqC13t9wGzRJca+Qa3hoAXkzv7wGrntw+dsBz1Glt1NeEsUkZ0xuZ1NHQKRYQy
         CeKxKHFWfc7/VovtQ8d19Z8gCqp8sNTtaUb4NPXlS5R0tNjIQP9/DuCKg6Lq9Iv5++
         CWnUKCJMRpJNASahfsgpG0EoActxBOkc/CCGjxGo7Bqa3iEUD5nAijBL/h6DsaHk1j
         B3CXR7/L/AV+aF58IlaGUiHHYyJBnLhEtTha8SWVZuuzfqZcNcjOsUTYHALjcW6Fla
         MoTkuy3WW2en/Qgou5jkbsbbpnsMnVbTJWhRI2FM9FSKAa782kKsUTK83ybLwV49aC
         kTQk+seDXnMdw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRWlGSWpSXmKPExsViZ8ORqNvjEpd
  sMGWfpsW7z1UW06deYLTYcuweo8XlJ3wWe9/NZrU4PWERk8XZX1dZLPbsPclicXnXHDaLXX92
  sFus/PGH1eLhgs3sFq09P9kt1vanO/B5nFok4bFrVyO7x+YVWh6L97xk8ti0qpPN48XmmYweT
  WeOMnu833eVzePzJrkAzijWzLyk/IoE1oyVK06yFPyQqOjqOsXUwHhBpIuRi0NIYAujxI2Va1
  ghnOVMErPmN7FDONsZJe5sX8/YxcjJwStgJ/H0SysTiM0ioCrR/rOXCSIuKHFy5hMWEFtUIFn
  i69SLYHFhAV+JtZv6mEFsEYFyiV1N95hAhjILPGGR6Dz4jg1iQzuLRNvS62Ab2AR0JC4s+At0
  BwcHp4CHRG9fAEiYWcBCYvGbg+wQtrxE89bZzCAlEgJKEjO740HCEgIVErNmtTFB2GoSV89tY
  p7AKDQLyXmzkEyahWTSAkbmVYzmxalFZalFuoaWeklFmekZJbmJmTl6iVW6iXqppbp5+UUlGb
  qGeonlxXqpxcV6xZW5yTkpenmpJZsYgXGbUpwavYNx7rI/eocYJTmYlER583/HJgvxJeWnVGY
  kFmfEF5XmpBYfYpTh4FCS4P1pHpcsJFiUmp5akZaZA0whMGkJDh4lEd4dxkBp3uKCxNzizHSI
  1ClGY47zO/fvZeaYOvvffmYhlrz8vFQpcd5TTkClAiClGaV5cINgqe0So6yUMC8jAwODEE9Ba
  lFuZgmq/CtGcQ5GJWFeX0egKTyZeSVw+14BncIEdEr6pCiQU0oSEVJSDUyeex/5vF5WnuWx8W
  q67vTJh0uO5vz8//uIzq/Pb07Yze2SedPF5CAhfvdwPOeL2deSM2Ivu6hfnn/mm+TXqP3HnNe
  4cDQcn23vvkRfYdfmtMcRl9cLctz7ZXtR0OyJ7ZJ1CUwLuPw6r9258P/81N7sVb1qoTUHf9ku
  tMy62S/BF7ds2kmfbwoV7ivCtK3v2+62DTyzSogxw2z/4ovi+9Y8FVTMfndxSvKS69EL96ft0
  Pu3t6h32e25V6RDzv3Wtjy/ZLroitMiTmfPHT4qFr5N11VQ0S7pjW7fBKl0lme7TnMez5jS2T
  Jf/7af3Sb9PVEt7mLrnHLnh5/duL3d9/oORslnRSIdU0XvKbZ9eso6QYmlOCPRUIu5qDgRAM5
  d55XoAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-7.tower-732.messagelabs.com!1667122316!339629!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27230 invoked from network); 30 Oct 2022 09:31:56 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-7.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Oct 2022 09:31:56 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 115A5100191;
        Sun, 30 Oct 2022 09:31:56 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 049C410018D;
        Sun, 30 Oct 2022 09:31:56 +0000 (GMT)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 30 Oct 2022 09:31:50 +0000
Message-ID: <7a3aac47-1492-a3cc-c53a-53c908f4f857@fujitsu.com>
Date:   Sun, 30 Oct 2022 17:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
To:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
CC:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        Theodore Ts'o <tytso@mit.edu>
References: <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia> <20221023220018.GX3600936@dread.disaster.area>
 <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20221024053109.GY3600936@dread.disaster.area>
 <dd00529c-d3ef-40e3-9dea-834c5203e3df@fujitsu.com>
 <Y1gjQ4wNZr3ve2+K@magnolia> <Y1rzZN0wgLcie47z@magnolia>
 <635b325d25889_6be129446@dwillia2-xfh.jf.intel.com.notmuch>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <635b325d25889_6be129446@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/10/28 9:37, Dan Williams 写道:
> Darrick J. Wong wrote:
>> [add tytso to cc since he asked about "How do you actually /get/ fsdax
>> mode these days?" this morning]
>>
>> On Tue, Oct 25, 2022 at 10:56:19AM -0700, Darrick J. Wong wrote:
>>> On Tue, Oct 25, 2022 at 02:26:50PM +0000, ruansy.fnst@fujitsu.com wrote:

...skip...

>>>
>>> Nope.  Since the announcement of pmem as a product, I have had 15
>>> minutes of acces to one preproduction prototype server with actual
>>> optane DIMMs in them.
>>>
>>> I have /never/ had access to real hardware to test any of this, so it's
>>> all configured via libvirt to simulate pmem in qemu:
>>> https://lore.kernel.org/linux-xfs/YzXsavOWMSuwTBEC@magnolia/
>>>
>>> /run/mtrdisk/[gh].mem are both regular files on a tmpfs filesystem:
>>>
>>> $ grep mtrdisk /proc/mounts
>>> none /run/mtrdisk tmpfs rw,relatime,size=82894848k,inode64 0 0
>>>
>>> $ ls -la /run/mtrdisk/[gh].mem
>>> -rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 18:09 /run/mtrdisk/g.mem
>>> -rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 19:28 /run/mtrdisk/h.mem
>>
>> Also forgot to mention that the VM with the fake pmem attached has a
>> script to do:
>>
>> ndctl create-namespace --mode fsdax --map dev -e namespace0.0 -f
>> ndctl create-namespace --mode fsdax --map dev -e namespace1.0 -f
>>
>> Every time the pmem device gets recreated, because apparently that's the
>> only way to get S_DAX mode nowadays?
> 
> If you have noticed a change here it is due to VM configuration not
> anything in the driver.
> 
> If you are interested there are two ways to get pmem declared the legacy
> way that predates any of the DAX work, the kernel calls it E820_PRAM,
> and the modern way by platform firmware tables like ACPI NFIT. The
> assumption with E820_PRAM is that it is dealing with battery backed
> NVDIMMs of small capacity. In that case the /dev/pmem device can support
> DAX operation by default because the necessary memory for the 'struct
> page' array for that memory is likely small.
> 
> Platform firmware defined PMEM can be terabytes. So the driver does not
> enable DAX by default because the user needs to make policy choice about
> burning gigabytes of DRAM for that metadata, or placing it in PMEM which
> is abundant, but slower. So what I suspect might be happening is your
> configuration changed from something that auto-allocated the 'struct
> page' array, to something that needed those commands you list above to
> explicitly opt-in to reserving some PMEM capacity for the page metadata.

I am using the same simulation environment as Darrick's and Dave's and 
have tested many times, but still cannot reproduce the failed cases they 
mentioned (dax+non_reflink mode, currently focuing) until now. Only a 
few cases randomly failed because of "target is busy". But IIRC, those 
failed cases you mentioned were failed with dmesg warning around the 
function "dax_associate_entry()" or "dax_disassociate_entry()". Since I 
cannot reproduce the failure, it hard for me to continue sovling the 
problem.

And how is your recent test?  Still failed with those dmesg warnings? 
If so, could you zip the test result and send it to me?


--
Thanks,
Ruan
