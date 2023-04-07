Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205406DAADE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbjDGJaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbjDGJaB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:30:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8549EE4
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 02:29:56 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230407092952epoutp03baf221a6f188d57bcda8978ce1c66a5d~TnRNkZgzp2373123731epoutp038
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 09:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230407092952epoutp03baf221a6f188d57bcda8978ce1c66a5d~TnRNkZgzp2373123731epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680859792;
        bh=WBdmuR/cda1hZo8GHvOtAuXpC6IuOQqMwXmO1krHcHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2VITLj5fyg8o6jgEdgf+zuIoZ7cUZasCHaRk1vC1wHgdpsx4mpwmXzANlysbdCJG
         0rtMKeHq7k4f9btnyETbEFMWJ65w51bdR6gLtPA8ugLK/kyjklWuMaIZOopvoX0lpp
         +7Q15XWQzOYZAHJ/3rPcAnPIPtMQtArQExMMi0yo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230407092951epcas2p3687896a1be80816768c31d7479c46b34~TnRM2z9yU1668416684epcas2p3C;
        Fri,  7 Apr 2023 09:29:51 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PtCkl1tYWz4x9Pw; Fri,  7 Apr
        2023 09:29:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.9F.61927.F82EF246; Fri,  7 Apr 2023 18:29:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230407092950epcas2p12bc20c2952a800cf3f4f1d0b695f67e2~TnRL_Jr451336213362epcas2p1R;
        Fri,  7 Apr 2023 09:29:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230407092950epsmtrp2d9886ba75122925b243ac626d18cd7fe~TnRL9Xw741724917249epsmtrp2-;
        Fri,  7 Apr 2023 09:29:50 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-dd-642fe28f25fc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.50.31821.E82EF246; Fri,  7 Apr 2023 18:29:50 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.99]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230407092950epsmtip1f0fa6492c8c175d6c50ddacfc02932a5~TnRLxlKKY1651816518epsmtip1Z;
        Fri,  7 Apr 2023 09:29:50 +0000 (GMT)
From:   Kyungsan Kim <ks0204.kim@samsung.com>
To:     ying.huang@intel.com, dragan@stancevic.com
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: RE: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Date:   Fri,  7 Apr 2023 18:29:50 +0900
Message-Id: <20230407092950.420757-1-ks0204.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87a5zky0c8.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmhW7/I/0UgyWtPBbTDytaTJ96gdHi
        0Nyb7BbnZ51isdiz9ySLxb01/1kt9r3ey2zxovM4k0XHhjeMFhvvv2OzODlrMosDt8e/E2vY
        PBbvecnksenTJHaPyTeWM3r0bVnF6LF4qY3H501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz2rb0sxWsiKl4sHEHSwNju3cXIyeH
        hICJxOT3K1m6GLk4hAR2MEoc3/KLEcL5xCjR8+YTM0iVkMBnRol9TbwwHROm34Mq2sUoMWHt
        baj2LiaJry9OM4JUsQloS/y5cp4NxBYR0JOY9+wHWJxZ4B+jxJ7Lkl2MHBzCAh4Sa6dwgIRZ
        BFQl/j/9wA5i8wrYSPR/nM8EsUxeYual72BxTgE7iXf3HzBC1AhKnJz5hAVipLxE89bZzBD1
        Ezkk1s9KhLBdJD5sXMEOYQtLvDq+BcqWkvj8bi8bhF0s8fj1P6h4icThJb9ZIGxjiXc3n7OC
        nMksoCmxfpc+iCkhoCxx5BbUVj6JjsN/2SHCvBIdbUIQjSoS2/8tZ4ZZdHr/JqjhHhKvpx9n
        gwTUREaJ7wf+s09gVJiF5JlZSJ6ZhbB4ASPzKkax1ILi3PTUYqMCQ3j0JufnbmIEp1ct1x2M
        k99+0DvEyMTBeIhRgoNZSYT3cp1eihBvSmJlVWpRfnxRaU5q8SFGU2BQT2SWEk3OByb4vJJ4
        QxNLAxMzM0NzI1MDcyVxXmnbk8lCAumJJanZqakFqUUwfUwcnFINTAYTnrx7/jF+Y6i+mvHP
        iwuXLxcqKq43XNA/fZ7JrJTWx5qZ35oOZAe+eHjgbLfDxQcWMlKG+6SfKWc87q+dz3St9sym
        NgffzODspZYX/HO2TX2+/8SUNdpfqh8kCb+OjN3ywsRifdDPPMOaWsmaiGMPei9xJEXesqk5
        /YGlrjxeR52xaJfD4ptVpUx5SdNOmxWndy2ruqgltzN/4pX3zK8yFndNZ7i04l/hpa9XN8Ys
        2PfJbh2n5dK8ZB7mHTM3vpLe++l6gLFJf132PLHpcny66gwzjv9636x3wrJ59gqZoAmOnE8y
        b3NnMNpH/Ti/n3GR7Ik/H1iUbi1pWqZuFyx1ttwvfi9H7axkpv3StkosxRmJhlrMRcWJAKSC
        6s84BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnG7fI/0Ug4Wr9SymH1a0mD71AqPF
        obk32S3OzzrFYrFn70kWi3tr/rNa7Hu9l9niRedxJouODW8YLTbef8dmcXLWZBYHbo9/J9aw
        eSze85LJY9OnSewek28sZ/To27KK0WPxUhuPz5vkAtijuGxSUnMyy1KL9O0SuDLatvSzFayI
        qXiwcQdLA2O7dxcjJ4eEgInEhOn3GLsYuTiEBHYwSkye8psFIiEl8f50GzuELSxxv+UIK4gt
        JNDBJDFrtTCIzSagLfHnynk2EFtEwECiteM7G8ggZpCarZenAzkcHMICHhJrp3CA1LAIqEr8
        f/oBbCavgI1E/8f5TBDz5SVmXvoOFucUsJN4d/8BI8QuW4mdhx6yQNQLSpyc+QTMZgaqb946
        m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4OW1g7GPas+
        6B1iZOJgPMQowcGsJMJ7uU4vRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Yklqdmp
        qQWpRTBZJg5OqQamhAbupKsCJSJy2VxHTn094KH45smSrw6R0aefxhz+KXb47pr4l9m8ffbv
        fO9tuXTzW2zz1odOv1ODhJluShVuErQ0TPnjVbz/SeAvkc3Xb9jez1pw10OIXfZEzqeV1ac6
        dT7JbIy1Xv51aeQ98w3fjGxn+GX6bls8ob2M4dnB/5Ur7h6wWGof9Irt6/kXsuHePMlVz332
        V8lG2yos23w7rCdKb07inR4NyYz8vYWdzvvkuJbPvl+ybJbf49DMApntdk+vOsaGft08/27S
        idYbjSWsx871Te3z0xa+s3Je+s30sOjFO2T2avCzh7dFbN3YkHE+zOC+Txv/l/rzk7fc7BLa
        cOHEhNr5P1R09RZvUGIpzkg01GIuKk4EAE2lG/H1AgAA
X-CMS-MailID: 20230407092950epcas2p12bc20c2952a800cf3f4f1d0b695f67e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230407092950epcas2p12bc20c2952a800cf3f4f1d0b695f67e2
References: <87a5zky0c8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CGME20230407092950epcas2p12bc20c2952a800cf3f4f1d0b695f67e2@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Dragan Stancevic <dragan@stancevic.com> writes:
>
>> Hi Ying-
>>
>> On 4/4/23 01:47, Huang, Ying wrote:
>>> Dragan Stancevic <dragan@stancevic.com> writes:
>>> 
>>>> Hi Mike,
>>>>
>>>> On 4/3/23 03:44, Mike Rapoport wrote:
>>>>> Hi Dragan,
>>>>> On Thu, Mar 30, 2023 at 05:03:24PM -0500, Dragan Stancevic wrote:
>>>>>> On 3/26/23 02:21, Mike Rapoport wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> [..] >> One problem we experienced was occured in the combination of
>>>>>> hot-remove and kerelspace allocation usecases.
>>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>>>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>>>>>>>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>>>>>>
>>>>>>> This still does not describe what are the use cases that require having
>>>>>>> kernel allocations on CXL.mem.
>>>>>>>
>>>>>>> I believe it's important to start with explanation *why* it is important to
>>>>>>> have kernel allocations on removable devices.
>>>>>>
>>>>>> Hi Mike,
>>>>>>
>>>>>> not speaking for Kyungsan here, but I am starting to tackle hypervisor
>>>>>> clustering and VM migration over cxl.mem [1].
>>>>>>
>>>>>> And in my mind, at least one reason that I can think of having kernel
>>>>>> allocations from cxl.mem devices is where you have multiple VH connections
>>>>>> sharing the memory [2]. Where for example you have a user space application
>>>>>> stored in cxl.mem, and then you want the metadata about this
>>>>>> process/application that the kernel keeps on one hypervisor be "passed on"
>>>>>> to another hypervisor. So basically the same way processors in a single
>>>>>> hypervisors cooperate on memory, you extend that across processors that span
>>>>>> over physical hypervisors. If that makes sense...
>>>>> Let me reiterate to make sure I understand your example.
>>>>> If we focus on VM usecase, your suggestion is to store VM's memory and
>>>>> associated KVM structures on a CXL.mem device shared by several nodes.
>>>>
>>>> Yes correct. That is what I am exploring, two different approaches:
>>>>
>>>> Approach 1: Use CXL.mem for VM migration between hypervisors. In this
>>>> approach the VM and the metadata executes/resides on a traditional
>>>> NUMA node (cpu+dram) and only uses CXL.mem to transition between
>>>> hypervisors. It's not kept permanently there. So basically on
>>>> hypervisor A you would do something along the lines of migrate_pages
>>>> into cxl.mem and then on hypervisor B you would migrate_pages from
>>>> cxl.mem and onto the regular NUMA node (cpu+dram).
>>>>
>>>> Approach 2: Use CXL.mem to cluster hypervisors to improve high
>>>> availability of VMs. In this approach the VM and metadata would be
>>>> kept in CXL.mem permanently and each hypervisor accessing this shared
>>>> memory could have the potential to schedule/run the VM if the other
>>>> hypervisor experienced a failure.
>>>>
>>>>> Even putting aside the aspect of keeping KVM structures on presumably
>>>>> slower memory,
>>>>
>>>> Totally agree, presumption of memory speed dully noted. As far as I am
>>>> aware, CXL.mem at this point has higher latency than DRAM, and
>>>> switched CXL.mem has an additional latency. That may or may not change
>>>> in the future, but even with actual CXL induced latency I think there
>>>> are benefits to the approaches.
>>>>
>>>> In the example #1 above, I think even if you had a very noisy VM that
>>>> is dirtying pages at a high rate, once migrate_pages has occurred, it
>>>> wouldn't have to be quiesced for the migration to happen. A migration
>>>> could basically occur in-between the CPU slices, once VCPU is done
>>>> with it's slice on hypervisor A, the next slice could be on hypervisor
>>>> B.
>>>>
>>>> And the example #2 above, you are trading memory speed for
>>>> high-availability. Where either hypervisor A or B could run the CPU
>>>> load of the VM. You could even have a VM where some of the VCPUs are
>>>> executing on hypervisor A and others on hypervisor B to be able to
>>>> shift CPU load across hypervisors in quasi real-time.
>>>>
>>>>
>>>>> what ZONE_EXMEM will provide that cannot be accomplished
>>>>> with having the cxl memory in a memoryless node and using that node to
>>>>> allocate VM metadata?
>>>>
>>>> It has crossed my mind to perhaps use NUMA node distance for the two
>>>> approaches above. But I think that is not sufficient because we can
>>>> have varying distance, and distance in itself doesn't indicate
>>>> switched/shared CXL.mem or non-switched/non-shared CXL.mem. Strictly
>>>> speaking just for myself here, with the two approaches above, the
>>>> crucial differentiator in order for #1 and #2 to work would be that
>>>> switched/shared CXL.mem would have to be indicated as such in a way.
>>>> Because switched memory would have to be treated and formatted in some
>>>> kind of ABI way that would allow hypervisors to cooperate and follow
>>>> certain protocols when using this memory.
>>>>
>>>>
>>>> I can't answer what ZONE_EXMEM will provide since we haven's seen
>>>> Kyungsan's talk yet, that's why I myself was very curious to find out
>>>> more about ZONE_EXMEM proposal and if it includes some provisions for
>>>> CXL switched/shared memory.
>>>>
>>>> To me, I don't think it makes a difference if pages are coming from
>>>> ZONE_NORMAL, or ZONE_EXMEM but the part that I was curious about was
>>>> if I could allocate from or migrate_pages to (ZONE_EXMEM | type
>>>> "SWITCHED/SHARED"). So it's not the zone that is crucial for me,  it's
>>>> the typing. That's what I meant with my initial response but I guess
>>>> it wasn't clear enough, "_if_ ZONE_EXMEM had some typing mechanism, in
>>>> my case, this is where you'd have kernel allocations on CXL.mem"
>>>>
>>> We have 2 choices here.
>>> a) Put CXL.mem in a separate NUMA node, with an existing ZONE type
>>> (normal or movable).  Then you can migrate pages there with
>>> move_pages(2) or migrate_pages(2).  Or you can run your workload on the
>>> CXL.mem with numactl.
>>> b) Put CXL.mem in an existing NUMA node, with a new ZONE type.  To
>>> control your workloads in user space, you need a set of new ABIs.
>>> Anything you cannot do in a)?
>>
>> I like the CXL.mem as a NUMA node approach, and also think it's best
>> to do this with move/migrate_pages and numactl and those a & b are
>> good choices.
>>
>> I think there is an option c too though, which is an amalgamation of a
>> & b. Here is my thinking, and please do let me know what you think
>> about this approach.
>>
>> If you think about CXL 3.0 shared/switched memory as a portal for a VM
>> to move from one hypervisor to another, I think each switched memory 
>> should be represented by it's own node and have a distinct type so the
>> migration path becomes more deterministic. I was thinking along the 
>> lines that there would be some kind of user space clustering/migration
>> app/script that runs on all the hypervisors. Which would read, let's
>> say /proc/pagetypeinfo to find these "portals":
>> Node 4, zone Normal, type Switched ....
>> Node 6, zone Normal, type Switched ....
>>
>> Then it would build a traversal Graph, find per hypervisor reach and
>> critical connections, where critical connections are cross-rack or 
>> cross-pod, perhaps something along the lines of this pseudo/python code:
>> class Graph:
>> 	def __init__(self, mydict):
>> 		self.dict = mydict
>> 		self.visited = set()
>> 		self.critical = list()
>> 		self.reach = dict()
>> 		self.id = 0
>> 	def depth_first_search(self, vertex, parent):
>> 		self.visited.add(vertex)
>> 		if vertex not in self.reach:
>> 			self.reach[vertex] = {'id':self.id, 'reach':self.id}
>> 			self.id += 1
>> 		for next_vertex in self.dict[vertex] - {parent}:
>> 			if next_vertex not in self.visited:
>> 				self.depth_first_search(next_vertex, vertex)
>> 			if self.reach[next_vertex]['reach'] < self.reach[vertex]['reach']:
>> 				self.reach[vertex]['reach'] = self.reach[next_vertex]['reach']
>> 		if parent != None and self.reach[vertex]['id'] ==
>> 		self.reach[vertex]['reach']:
>> 			self.critical.append([parent, vertex])
>> 		return self.critical
>>
>> critical = mygraph.depth_first_search("hostname-foo4", None)
>>
>> that way you could have a VM migrate between only two hypervisors
>> sharing switched memory, or pass through a subset of hypervisors (that 
>> don't necessarily share switched memory) to reach it's
>> destination. This may be rack confined, or across a rack or even a pod
>> using critical connections.
>>
>> Long way of saying that if you do a) then the clustering/migration
>> script only sees a bunch of nodes and a bunch of normal zones it 
>> wouldn't know how to build the "flight-path" and where to send a
>> VM. You'd probably have to add an additional interface in the kernel
>> for the script to query the paths somehow, where on the other hand
>> pulling things from proc/sys is easy.
>>
>>
>> And then if you do b) and put it in an existing NUMA and with a
>> "Switched" type, you could potentially end up with several "Switched" 
>> types under the same node. So when you numactl/move/migrate pages they
>> could go in either direction and you could send some pages through one 
>> "portal" and others through another "portal", which is not what you
>> want to do.
>>
>> That's why I think the c option might be the most optimal, where each
>> switched memory has it's own node number. And then displaying type as 
>> "Switched" just makes it easier to detect and Graph the topology.
>>
>>
>> And with regards to an ABI, I was referring to an ABI needed between
>> the kernels running on separate hypervisors. When hypervisor B boots,
>> it needs to detect through an ABI if this switched/shared memory is
>> already initialized and if there are VMs in there which are used by
>> another hypervisor, say A. Also during the migration, hypervisors A
>> and B would have to use this ABI to synchronize the hand-off between
>> the two physical hosts. Not an all-inclusive list, but I was referring
>> to those types of scenarios.
>>
>> What do you think?
>
>It seems unnecessary to add a new zone type to mark a node with some
>attribute.  For example, in the following patch, a per-node attribute
>can be added and shown in sysfs.
>

Hi Dragan, could you please confirm if I understand the a,b correctly?
a = the flow of page move/migration among switched nodes. Here, the switch node is "b" as one single node.
b = a node that is composed of multiple CXL DRAM devices under single or multi-level switch.

Hi Ying,
ZONE_EXMEM not only means adding an attribute in a node, but also provides provisioning among CXL.mem channels.
To be specific, multiple CXL DRAM devices can be composed as ZONE_EXMEM using sysfs or cli[1], as a result userland is able to handle it as a single node.

[1] https://github.com/OpenMPDK/SMDK/wiki/4.-Kernel#n-way-grouping
>https://lore.kernel.org/linux-mm/20220704135833.1496303-10-martin.fernandez@eclypsium.com/
>
>Best Regards,
>Huang, Ying
